//
//  LibraryViewController.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 11/29/21.
//

import UIKit
import CoreData

class LibraryViewController: UIViewController {
    
    var petsLoadViewModel = [PetsViewModelEntity]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
        return createSectionLayout(section: sectionIndex)
    }))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
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
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        loadBalances()
        collectionView.reloadData()
        
    }
    func loadBalances() {
        let request: NSFetchRequest<PetsViewModelEntity> = PetsViewModelEntity.fetchRequest()
     


        do {
            petsLoadViewModel = try context.fetch(request)
        

        } catch {
            print("Error fetching data \(error)")
        }
    }

}

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petsLoadViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        


        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewAnimalsCollectionViewCell.identifier, for: indexPath) as? NewAnimalsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let newPets = petsLoadViewModel[indexPath.row]

        cell.configureCoreData(with: newPets)
       // cell.configure(with: newPets)
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
    
  
    

}
