//
//  CollectionViewController.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import UIKit
import SwiftUI

protocol DataConfigurable {
    associatedtype Content: Hashable
    associatedtype V: View
    
    static func configure(with data: Content) -> V
}

struct CollectionView<Cell: View & DataConfigurable>: UIViewRepresentable {
    let cell: Cell.Type
    let data: [Cell.Content]
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> some UIView {
        let coordinator = context.coordinator
        coordinator.applySnapshot()
        return coordinator.collectionView
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(cell: cell.self, items: data)
    }
    
    @MainActor
    final internal class Coordinator: NSObject {
        let cell: Cell.Type
        let items: [Cell.Content]
        
        init(cell: Cell.Type, items: [Cell.Content]) {
            self.items = items
            self.cell = cell
        }
        
        lazy var collectionView: UICollectionView = {
            let layout = createLeftAlignedLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            return collectionView
        }()
        
        private lazy var datasource = makeDatasource()
        
        private func makeDatasource() -> UICollectionViewDiffableDataSource<Int, Cell.Content> {
            return UICollectionViewDiffableDataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
                let container = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                
                let config = UIHostingConfiguration {
                    self?.cell.configure(with: itemIdentifier)
                }
                
                let label = config.makeContentView()
                label.translatesAutoresizingMaskIntoConstraints = false
                
                container.addSubview(label)
                
                container.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
                container.topAnchor.constraint(equalTo: label.topAnchor).isActive = true
                container.trailingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
                container.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
                
                return container
            }
        }
        
        func applySnapshot() {
            var snapshot = NSDiffableDataSourceSnapshot<Int, Cell.Content>()
            snapshot.appendSections([1])
            snapshot.appendItems(items)
            
            datasource.apply(snapshot)
        }
        
        private func createLeftAlignedLayout() -> UICollectionViewLayout {
            let size = NSCollectionLayoutSize(widthDimension: .estimated(40),
                                              heightDimension: .absolute(48))
            let item = NSCollectionLayoutItem(layoutSize: size)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(50))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            group.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            group.interItemSpacing = .fixed(0)
            
            return UICollectionViewCompositionalLayout(section: .init(group: group))
        }
    }
}
