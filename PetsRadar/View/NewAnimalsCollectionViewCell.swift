//
//  NewAnimalsCollectionViewCell.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 11/30/21.
//

import UIKit
import SDWebImage

class NewAnimalsCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewAnimalsCollectionViewCell"
    
    private let animalsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let animalsNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let animalsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        contentView.addSubview(animalsImageView)
        contentView.addSubview(animalsNameLabel)
        contentView.addSubview(animalsDescriptionLabel)
        contentView.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        animalsNameLabel.frame = CGRect(x: 3, y: contentView.height-44, width: contentView.width-6, height: 44)
        animalsDescriptionLabel.frame = CGRect(x: 3, y: contentView.height-70, width: contentView.width-6, height: 44)
        let imageSize = contentView.height-70
        animalsImageView.frame = CGRect(x: (contentView.width-imageSize)/2, y: 3, width: imageSize, height: imageSize)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        animalsNameLabel.text = nil
        animalsDescriptionLabel.text = nil
        animalsImageView.image = nil
    }
    
    func configure(with viewModel: NewAnimalsCellViewModel) {
        animalsNameLabel.text = viewModel.name
        animalsDescriptionLabel.text = viewModel.description
        animalsImageView.sd_setImage(with: viewModel.artworkURL, placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
        
    }
    
    
}
