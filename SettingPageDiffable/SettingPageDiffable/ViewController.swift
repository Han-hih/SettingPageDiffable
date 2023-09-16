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
        Table(title: "방해 금지 모드"),
        Table(title: "수면"),
        Table(title: "업무"),
        Table(title: "개인 시간")
    ]
    
    let secondList = [
    Table(title: "모든 기기에서 공유")
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
        configuration.showsSeparators = false
        configuration.backgroundColor = .white
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Table> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            if itemIdentifier.title == "방해 금지 모드" {
                content.image =  UIImage(systemName: "moon.fill")
                content.imageProperties.tintColor = .red
            } else if itemIdentifier.title == "수면" {
                content.image = UIImage(systemName: "bed.double.fill")
                content.imageProperties.tintColor = .blue
            } else if itemIdentifier.title == "업무" {
                content.image = UIImage(systemName: "phone.fill")
                content.imageProperties.tintColor = .brown
            } else {
                content.image = UIImage(systemName: "person.fill")
                content.imageProperties.tintColor = .cyan
            }
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
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

