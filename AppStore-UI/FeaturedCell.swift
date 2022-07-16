//
//  FeaturedCell.swift
//  AppStore-UI
//
//  Created by Artemy Ozerski on 13/07/2022.
//

import UIKit

class FeaturedCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseIdentifier = "FeaturedCell"
    var taglineLabel = UILabel()
    var nameLabel = UILabel()
    var subheadingLabel = UILabel()
    var imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel

        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        taglineLabel.textColor = .systemBlue
        taglineLabel.font = .systemFont(ofSize: 12)

        let stackView = UIStackView(arrangedSubviews: [separator, taglineLabel, nameLabel, subheadingLabel, imageView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        stackView.setCustomSpacing(10, after: subheadingLabel)
        stackView.setCustomSpacing(10, after: separator)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell(with app: App) {
        taglineLabel.text = app.tagline.uppercased()
        nameLabel.text = app.name
        subheadingLabel.text = app.subheading
        imageView.image = UIImage(named: app.image)
    }

}
