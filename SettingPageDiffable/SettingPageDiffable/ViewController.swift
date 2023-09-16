//
//  ViewController.swift
//  SettingPageDiffable
//
//  Created by 황인호 on 2023/09/15.
//

import UIKit

class ViewController: UIViewController {

    enum Section: Int, CaseIterable {
        case first = 0
        case second = 1
    }
    
    let firstList = [
        Table(title: "방해 금지 모드", secondTitle: "켬", accessoryText: "켬", image: "moon.fill", color: .red),
        Table(title: "수면", secondTitle: "", accessoryText: "", image: "bed.double.fill", color: .yellow),
        Table(title: "업무", secondTitle: "09:00 ~ 06:00", accessoryText: "", image: "phone.fill", color: .blue),
        Table(title: "개인 시간", secondTitle: "설정", accessoryText: "설정", image: "person.fill", color: .green)
    ]
    
    let secondList = [
        Table(title: "모든 기기에서 공유", secondTitle: "", accessoryText: "", image: "", color: .clear)
    ]
    
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Table>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        setAutoLayout()
        var snapshot = NSDiffableDataSourceSnapshot<Section, Table>()
        
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(firstList, toSection: .first)
        snapshot.appendItems(secondList, toSection: .second)
        
        configureDataSource()
        
        dataSource.apply(snapshot)
        
    }

    static func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = true
        configuration.backgroundColor = .white
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Table> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.secondaryText = itemIdentifier.secondTitle
            content.prefersSideBySideTextAndSecondaryText = false
            content.image = UIImage(systemName: "\(itemIdentifier.image)")
            content.imageProperties.tintColor = itemIdentifier.color
            content.imageToTextPadding = 20
            
            cell.contentConfiguration = content
            cell.accessories = [.label(text: "\(itemIdentifier.accessoryText)") ,.disclosureIndicator()]
        
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            cell.backgroundColor = .lightGray
            return cell
        })
    }
    func setAutoLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

