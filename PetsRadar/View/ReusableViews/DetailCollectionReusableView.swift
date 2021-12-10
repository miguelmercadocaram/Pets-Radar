//
//  DetailCollectionReusableView.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 12/2/21.
//

import UIKit

class DetailCollectionReusableView: UICollectionReusableView {
        static let identifier = "DetailCollectionReusableView"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let tagsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let breedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    

    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(tagsLabel)
        addSubview(ageLabel)
        addSubview(breedLabel)
        addSubview(colorLabel)
        addSubview(genderLabel)
        addSubview(emailLabel)
        addSubview(phoneLabel)
       
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        let imageSize: CGFloat = height/1.8
        imageView.frame = CGRect(x: (width-imageSize)/2, y: 20, width: imageSize, height: imageSize)
        
        nameLabel.frame = CGRect(x: 10, y: imageView.bottom, width: width-20, height: 30)
       
        tagsLabel.frame = CGRect(x: 10, y: nameLabel.bottom, width: width-20, height: 20)
        descriptionLabel.frame = CGRect(x: 10, y: tagsLabel.bottom, width: width, height: 30)
        ageLabel.frame = CGRect(x: 10, y: descriptionLabel.bottom, width: width, height: 20)
        breedLabel.frame = CGRect(x: 10, y: ageLabel.bottom, width: width, height: 20)
        colorLabel.frame = CGRect(x: 10, y: breedLabel.bottom, width: width, height: 20)
        genderLabel.frame = CGRect(x: 10, y: colorLabel.bottom, width: width, height: 20)
        emailLabel.frame = CGRect(x: 10, y: genderLabel.bottom, width: width, height: 20)
        phoneLabel.frame = CGRect(x: 10, y: emailLabel.bottom, width: width, height: 20)
        
        
        
    }
    
    func configure(with viewModels: NewAnimalsCellViewModel) {
        nameLabel.text = viewModels.name
        tagsLabel.text = viewModels.tag
        descriptionLabel.text = viewModels.description
        ageLabel.text = viewModels.age
        breedLabel.text = viewModels.breed
        colorLabel.text = viewModels.color
        genderLabel.text = viewModels.gender
        emailLabel.text = viewModels.email
        phoneLabel.text = viewModels.phone
        imageView.sd_setImage(with: viewModels.artworkURL, placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
    }
}
