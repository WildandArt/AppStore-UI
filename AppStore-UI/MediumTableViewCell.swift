//
//  MediumTableViewCell.swift
//  AppStore-UI
//
//  Created by Artemy Ozerski on 16/07/2022.
//

import UIKit
//28:33
class MediumTableViewCell: UICollectionViewCell, SelfConfiguringCell {
    let button = UIButton(type: .custom)
    let imageView = UIImageView()
    let name = UILabel()
    let subheading = UILabel()

    static var reuseIdentifier = "MediumTableCell"

    func configureCell(with app: App) {

        imageView.image = UIImage(named: app.image)
        name.text = app.name
        subheading.text = app.subheading
        button.imageView?.image = UIImage(systemName: "icloud.and.arrow.down")

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit


        let innerStackView = UIStackView(arrangedSubviews: [name, subheading])
        innerStackView.axis = .vertical
        let outerStackView = UIStackView(arrangedSubviews: [imageView, innerStackView, button])
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(outerStackView)
        NSLayoutConstraint.activate([
            outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
