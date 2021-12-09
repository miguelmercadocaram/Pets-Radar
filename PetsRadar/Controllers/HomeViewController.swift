//
//  HomeViewController.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 11/29/21.
//

import UIKit
import CoreData

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
    private var favoritesCoreDataModel = [PetsViewModelEntity]()
    private var nextPage = 1
    private var isWaiting = false
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
                    self?.newAnimals = model
                    self?.viewModels = model.compactMap({
                        //NewAnimalsCellViewModel(name: $0.name, description: $0.description ?? "-", artworkURL: URL(string: $0.photos?.first?.large ?? "-"))
                        NewAnimalsCellViewModel(name: $0.name, description: $0.description ?? "No description", artworkURL: URL(string: $0.photos?.first?.large ?? "-"), status: $0.status, age: $0.age, email: $0.contact?.email, phone: $0.contact?.phone, address: $0.contact?.address?.address1, city: $0.contact?.address?.city, breed: $0.breeds?.primary, gender: $0.gender, tag: $0.tags?.first, color: $0.colors?.primary)
                    })
                    self?.collectionView.reloadData()
                }

            case .failure(let error):
                print(error)
            }
        }
        configureCollectionView()
        view.addSubview(spinner)
        
        addLongTapGesture()
  
        

    }
    
    private func addLongTapGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        collectionView.addGestureRecognizer(gesture)
    }
    
    @objc func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else {
            return
        }
        let touchPoint = gesture.location(in: collectionView)
        
        guard let indexPath = collectionView.indexPathForItem(at: touchPoint) else {
            return
        }
        let model = viewModels[indexPath.row]
        
        let actionSheet = UIAlertController(title: model.name, message: "Would you like to add this to favorites?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Add to Favorites", style: .default, handler: { [weak self] _ in
            let petsCoreModel = PetsViewModelEntity(context: self!.context)
            
            petsCoreModel.name = model.name
            petsCoreModel.artworkURL = model.artworkURL
            petsCoreModel.tag = model.tag
            
            self?.favoritesCoreDataModel.append(petsCoreModel)
            
            self?.savePets()
         
        }))
        present(actionSheet, animated: true, completion: nil)
    }
    
    func savePets() {
        do {
            try context.save()
        }catch {
            print("Error saving context \(error)")
        }
    }

    private func updateNextSet() {
        
            APICaller.shared.getAnimalsNextPage(page: nextPage) { [weak self] result in
                switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        self?.viewModels.append(contentsOf: model.compactMap({
                            //NewAnimalsCellViewModel(name: $0.name, description: $0.description ?? "-", artworkURL: URL(string: $0.photos?.first?.large ?? "-"))
                            NewAnimalsCellViewModel(name: $0.name, description: $0.description ?? "No description", artworkURL: URL(string: $0.photos?.first?.large ?? "-"), status: $0.status, age: $0.age, email: $0.contact?.email, phone: $0.contact?.phone, address: $0.contact?.address?.address1, city: $0.contact?.address?.city, breed: $0.breeds?.primary, gender: $0.gender, tag: $0.tags?.first, color: $0.colors?.primary)
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
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        


        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewAnimalsCollectionViewCell.identifier, for: indexPath) as? NewAnimalsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
            let newPets = viewModels[indexPath.row]
//            cell.configure(with: NewAnimalsCellViewModel(name: newPets.name, description: newPets.status ?? "-", artworkURL: URL(string: newPets.photos?.first?.large ?? "_")))
           
//        let petsCoreModel = PetsViewModelEntity(context: self.context)
//        
//        petsCoreModel.name = newPets.name
//        petsCoreModel.artworkURL = newPets.artworkURL
//        petsCoreModel.tag = newPets.tag
//        
//        self.favoritesCoreDataModel.append(petsCoreModel)
        
        
        
        cell.configure(with: newPets)
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
          //reloadArray()
            collectionView.reloadData()

           }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pets = viewModels[indexPath.row]
        let detailVC = DetailViewController(animals: pets)
        print(newAnimals)
        detailVC.title = pets.name
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
    

}
