//
//  BreedsDetailsCollectionViewCell.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 12/7/21.
//

import UIKit

class BreedsDetailsCollectionViewCell: UICollectionViewCell {
    static let identifier = "BreedsDetailsCollectionViewCell"
    
    private let breedCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let breedNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    
    private let otherLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(breedCoverImageView)
        contentView.addSubview(breedNameLabel)
        contentView.addSubview(otherLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        otherLabel.frame = CGRect(x: 3, y: contentView.height-44, width: contentView.width-6, height: 44)
        breedNameLabel.frame = CGRect(x: 3, y: contentView.height-70, width: contentView.width-6, height: 44)
        otherLabel.frame = CGRect(x: 3, y: contentView.height-44, width: contentView.width-6, height: 44)
        let imageSize = contentView.height-70
        breedCoverImageView.frame = CGRect(x: (contentView.width-imageSize)/2, y: 3, width: imageSize, height: imageSize)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        breedNameLabel.text = nil
        otherLabel.text = nil
        breedCoverImageView.image = nil
    }
    
    func configure(with viewModel: NewAnimalsCellViewModel) {
        breedNameLabel.text = viewModel.name
        breedCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }

}
