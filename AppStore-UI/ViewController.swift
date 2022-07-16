//
//  ViewController.swift
//  AppStore-UI
//
//  Created by Artemy Ozerski on 13/07/2022.
//

import UIKit

class ViewController: UIViewController {
    let sections = Bundle.main.decode(type: [Section].self, from: "appstore.json")
    var collectionView : UICollectionView! = nil
    var dataSource : UICollectionViewDiffableDataSource<Section, App>! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
       
       
       // navigationItem.title = "Large"
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.addSubview(collectionView)
        collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier)
        collectionView.register(MediumTableViewCell.self, forCellWithReuseIdentifier: MediumTableViewCell.reuseIdentifier)

        createDataSource()
        reloadData()
    }

//
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = self.sections[sectionIndex]

            switch section.type {
            case "mediumTable":
                return self.createMediumTableSection(using: section)
            default:
                return self.createFeaturedSection(using: section)
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    func createMediumTableSection(using section : Section)-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.55))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    func createFeaturedSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(350))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        return layoutSection
    }
//
    func configure<T: SelfConfiguringCell>(_ cellType : T.Type, with app : App, for indexPath: IndexPath)->T{
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else{
            fatalError("failed with \(cellType)")
        }
        cell.configureCell(with: app)
        return cell
    }
    func createDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, App>(collectionView: collectionView, cellProvider: { collectionView, indexPath, app in
            switch self.sections[indexPath.section].type{
            case "mediumTable":
                return self.configure(MediumTableViewCell.self, with: app, for: indexPath)
            default:
                return self.configure(FeaturedCell.self, with: app, for: indexPath)
            }


        })
    }
    func reloadData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, App>()
        snapshot.appendSections(sections)
//        sections.forEach { section in
//            snapshot.appendItems(section.items)
//        }
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource.apply(snapshot)
    }

}

