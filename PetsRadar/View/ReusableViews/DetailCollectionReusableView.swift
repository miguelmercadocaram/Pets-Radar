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
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let tagsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(tagsLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        let imageSize: CGFloat = height/1.8
        imageView.frame = CGRect(x: (width-imageSize)/2, y: 20, width: imageSize, height: imageSize)
        
        nameLabel.frame = CGRect(x: 10, y: imageView.bottom, width: width-20, height: 44)
        descriptionLabel.frame = CGRect(x: 10, y: nameLabel.bottom, width: width-20, height: 44)
        tagsLabel.frame = CGRect(x: 10, y: descriptionLabel.bottom, width: width-20, height: 44)
    }
    
    func configure(with viewModels: DetailsCollectionViewCellViewModel) {
        nameLabel.text = viewModels.name
        tagsLabel.text = viewModels.tags
        descriptionLabel.text = viewModels.description
        //imageView.sd_setImage(with: viewModels.artworkURL, completed: nil)
        imageView.sd_setImage(with: viewModels.photos, placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
    }
}
