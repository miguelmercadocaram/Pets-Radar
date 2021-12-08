//
//  SearchViewController.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 11/29/21.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultViewController())
        vc.searchBar.placeholder = "Get A Dog Breed"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()
    
    private let breeds: [String] = [
    "Affenpinscher",
    "Akita",
    "pug",
    "samoyed",
    "Akbash",
    "Basset Hound",
    "Cocker Spaniel",
    "Dachshund",
    "Corgi"
    
    ]
    
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)), subitem: item, count: 2)
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        return NSCollectionLayoutSection(group: group)
    }))
    
    private var animals = [NewAnimalsCellViewModel]()
    
    private var breedsViewModel = [BreedCollectionViewCellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        view.addSubview(collectionView)
        searchController.searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(BreedCollectionViewCell.self, forCellWithReuseIdentifier: BreedCollectionViewCell.identifier)
        guard let breed = breeds.randomElement() else {
            return
        }

      
        APICaller.shared.getAnimalsBreeds { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let breeds):
                    self?.breedsViewModel = breeds.compactMap({
                        BreedCollectionViewCellViewModel(breed: $0.name, image: nil)
                    })
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
        collectionView.reloadData()
    
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.frame
    }
  

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard  let resultsController = searchController.searchResultsController as? SearchResultViewController, let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
       
        APICaller.shared.getBreeds(breed: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    resultsController.update(with: model)
                case .failure(let error):
                    print(error)
                }
            }
        }
       
        searchBar.endEditing(true)
        collectionView.reloadData()

    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breedsViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedCollectionViewCell.identifier, for: indexPath) as? BreedCollectionViewCell else {
            return UICollectionViewCell()
        }
        let newBreed = breedsViewModel[indexPath.row]
        cell.configure(with: newBreed)
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let breed = breedsViewModel[indexPath.row]
        let vc = BreedsViewController(breed: breed)
    
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    

    
    
}
