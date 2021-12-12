//
//  DetailViewController.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 12/2/21.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: {_,_ in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)), subitem: item, count: 2)
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
      
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.58)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
     
        
        return section
    }))
    
    private var viewModels = [DetailsCollectionViewCellViewModel]()
    
    private var animal: [Animal] = []

    private var animals: NewAnimalsCellViewModel
    
    private var newViewModels = [NewAnimalsCellViewModel]()
    
    init(animals: NewAnimalsCellViewModel) {
        self.animals = animals
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = animal.first?.name
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(NewAnimalsCollectionViewCell.self, forCellWithReuseIdentifier: NewAnimalsCollectionViewCell.identifier)
        collectionView.register(DetailCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailCollectionReusableView.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        

        APICaller.shared.getAnimals { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.newViewModels = model.compactMap({
                        NewAnimalsCellViewModel(name: $0.name, description: $0.description ?? "No description", artworkURL: URL(string: $0.photos?.first?.large ?? "-"), status: $0.status, age: $0.age, email: $0.contact?.email, phone: $0.contact?.phone, address: $0.contact?.address?.address1, city: $0.contact?.address?.city, breed: $0.breeds?.primary, gender: $0.gender, tag: $0.tags?.first, color: $0.colors?.primary)
                    })
                    self?.collectionView.reloadData()
                }

            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewAnimalsCollectionViewCell.identifier, for: indexPath) as? NewAnimalsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let pets = newViewModels[indexPath.row]
        cell.configure(with: pets)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailCollectionReusableView.identifier, for: indexPath) as? DetailCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
       
        
        let headerViewModel =  NewAnimalsCellViewModel(name: animals.name, description: animals.description, artworkURL: animals.artworkURL, status: animals.status, age: animals.age, email: animals.email, phone: animals.phone, address: animals.address, city: animals.city, breed: animals.breed, gender: animals.gender, tag: animals.tag, color: animals.color)
         header.configure(with: headerViewModel)
        return header
 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pets = newViewModels[indexPath.row]
        let detailVC = DetailViewController(animals: pets)
        detailVC.title = pets.name
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
