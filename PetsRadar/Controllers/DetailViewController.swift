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
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)
        
        // Group
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60)), subitem: item, count: 1)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        return section
    }))
    
    private var viewModels = [DetailsCollectionViewCellViewModel]()
    
    private var animal: [Animal] = []

    private var animals: NewAnimalsCellViewModel
    
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
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
        collectionView.register(DetailCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailCollectionReusableView.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        APICaller.shared.getAnimals { [weak self] result in
//            switch result {
//            case .success(let model):
//                DispatchQueue.main.async {
//                    self?.animal = model
//
//                    self?.collectionView.reloadData()
//                }
//
//            case .failure(let error):
//                print(error)
//            }
//        }
        
//        APICaller.shared.getAnimalsID(animalId: animals) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let model):
//
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
        
        
        
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
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as? DetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailCollectionReusableView.identifier, for: indexPath) as? DetailCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
//        let headerViewModel = DetailsCollectionViewCellViewModel(name: animal.first?.name, age: animal.first?.age, description: animal.first?.description ?? "-", photos: URL(string: animal.first?.photos?.first?.large ?? "-"), tags: animal.first?.tags?.first)
       // let headerViewModel = DetailsCollectionViewCellViewModel(name: animals.name, age: animals.age, description: animals.description ?? "No Description", photos: URL(string: animals.photos?.first?.large ?? ""), tags: animals.tags?.first)
       // let headerViewModel = NewAnimalsCellViewModel(name: animals.name, description: animals.description, artworkURL: animals.artworkURL)
       
        
        let headerViewModel =  NewAnimalsCellViewModel(name: animals.name, description: animals.description ?? "No description", artworkURL: animals.artworkURL, status: animals.status, age: animals.age, email: animals.email, phone: animals.phone, address: animals.address, city: animals.city, breed: animals.breed, gender: animals.gender, tag: animals.tag, color: animals.color)
         header.configure(with: headerViewModel)
        return header
 
    }
}
