//
//  BreedsViewController.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 12/7/21.
//

import UIKit

class BreedsViewController: UIViewController {

    let breed: BreedCollectionViewCellViewModel
    
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitem: item, count: 2)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        return NSCollectionLayoutSection(group: group)
    }))
    
    init(breed: BreedCollectionViewCellViewModel) {
        self.breed = breed
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var breeds = [NewAnimalsCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = breed.breed
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BreedsDetailsCollectionViewCell.self, forCellWithReuseIdentifier: BreedsDetailsCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        

        guard let arr = breed.breed.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }

        APICaller.shared.getBreeds(breed: arr) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let breeds):
                    self?.breeds = breeds.compactMap({
                        NewAnimalsCellViewModel(name: $0.name, description: $0.description ?? "No description", artworkURL: URL(string: $0.photos?.first?.large ?? "-"), status: $0.status, age: $0.age, email: $0.contact?.email, phone: $0.contact?.phone, address: $0.contact?.address?.address1, city: $0.contact?.address?.city, breed: $0.breeds?.primary, gender: $0.gender, tag: $0.tags?.first, color: $0.colors?.primary)
                    })
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
                
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }


}

extension BreedsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedsDetailsCollectionViewCell.identifier, for: indexPath) as? BreedsDetailsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let breeds = breeds[indexPath.row]
        cell.configure(with: breeds)
        return cell
}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pets = breeds[indexPath.row]
        let detailVC = DetailViewController(animals: pets)
        detailVC.title = pets.name
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
    


}
