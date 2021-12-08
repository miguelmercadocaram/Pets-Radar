//
//  SearchResultViewController.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 12/6/21.
//

import UIKit




class SearchResultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var viewModels: [NewAnimalsCellViewModel] = []
    
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitem: item, count: 2)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        return NSCollectionLayoutSection(group: group)
    }))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BreedsDetailsCollectionViewCell.self, forCellWithReuseIdentifier: BreedsDetailsCollectionViewCell.identifier)
     
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.frame
    }
    
    func update(with results: [Animal]) {
        self.viewModels = results.compactMap({
            NewAnimalsCellViewModel(name: $0.name, description: $0.description ?? "No description", artworkURL: URL(string: $0.photos?.first?.large ?? "-"), status: $0.status, age: $0.age, email: $0.contact?.email, phone: $0.contact?.phone, address: $0.contact?.address?.address1, city: $0.contact?.address?.city, breed: $0.breeds?.primary, gender: $0.gender, tag: $0.tags?.first, color: $0.colors?.primary)
        })
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedsDetailsCollectionViewCell.identifier, for: indexPath) as? BreedsDetailsCollectionViewCell else {
                return UICollectionViewCell()
            }
        let pets = viewModels[indexPath.row]
        cell.configure(with: pets)
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pets = viewModels[indexPath.row]
        let detailVC = DetailViewController(animals: pets)
        detailVC.title = pets.name
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
        present(detailVC, animated: true, completion: nil)
    }
    }


