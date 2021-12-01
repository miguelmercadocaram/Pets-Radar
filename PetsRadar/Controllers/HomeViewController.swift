//
//  HomeViewController.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 11/29/21.
//

import UIKit

enum BrowseSectionType {
    case newAnimals(viewModels: [NewAnimalsCellViewModel])
    
    var title: String {
        switch self {
        case .newAnimals:
            return "New Animals"
        }
    }
    
}

class HomeViewController: UIViewController {
    
    private var newAnimals = [Animal]()
    private var viewModels = [NewAnimalsCellViewModel]()
    private var nextPage = 1
    private var isWaiting = false
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
        return createSectionLayout(section: sectionIndex)
    }))
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private var sections = [BrowseSectionType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = .systemBackground
        
      
        APICaller.shared.getAnimals { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                   // self?.newAnimals = model
                    self?.viewModels = model.compactMap({
                        NewAnimalsCellViewModel(name: $0.name, description: $0.description ?? "-", artworkURL: URL(string: $0.photos?.first?.large ?? "-"))
                    })
                    self?.collectionView.reloadData()
                }
              
            case .failure(let error):
                print(error)
            }
        }
     
        //self.configureModels(newAnimals: newAnimals)
        //print(newAnimals.map({$0.name}))
        configureCollectionView()
        view.addSubview(spinner)
        
     
    }
    
    private func updateNextSet() {
        
            APICaller.shared.getAnimalsNextPage(page: nextPage) { [weak self] result in
                switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        self?.viewModels.append(contentsOf: model.compactMap({
                            NewAnimalsCellViewModel(name: $0.name, description: $0.description ?? "-", artworkURL: URL(string: $0.photos?.first?.large ?? "-"))
                        }))
                        
                        self?.collectionView.reloadData()
                      
                    }
                  
                case .failure(let error):
                    print(error)
                }
            }
        
 
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(NewAnimalsCollectionViewCell.self, forCellWithReuseIdentifier: NewAnimalsCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
      
    }
    
    private func configureModels(newAnimals: [Animal]) {
        self.newAnimals = newAnimals
        
        sections.append(.newAnimals(viewModels: newAnimals.compactMap({
            return NewAnimalsCellViewModel(name: $0.name , description: $0.description ?? "-", artworkURL: URL(string: $0.photos?.first?.full ?? "-"))
        })))
        collectionView.reloadData()
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

       // let newPets = newAnimals[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewAnimalsCollectionViewCell.identifier, for: indexPath) as? NewAnimalsCollectionViewCell else {
            return UICollectionViewCell()
        }
//        cell.configure(with: NewAnimalsCellViewModel(name: newPets.name, description: newPets.status ?? "-", artworkURL: URL(string: newPets.photos?.first?.large ?? "_")))
        cell.configure(with: viewModels[indexPath.row])
        
        
        return cell
        
    }
    
    public static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {

        switch section {
        case 0:

            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)), subitem: item, count: 2)
            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            return NSCollectionLayoutSection(group: group)
            
        default:
            
            // Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            // Group
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(360)), subitem: item, count: 1)
            
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            nextPage += 1
            updateNextSet()
           
           }
    }
    

}
