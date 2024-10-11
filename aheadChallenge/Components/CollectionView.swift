//
//  CollectionViewController.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import UIKit
import SwiftUI

protocol ViewSource {
    associatedtype Content: Hashable
    associatedtype V: View
    
    func view(for content: Content) -> V
}

struct CollectionView<Datasource: ViewSource>: UIViewRepresentable {
    let source: Datasource
    @Binding var items: [Datasource.Content]
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        context.coordinator.applySnapshot(items: items)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let coordinator = context.coordinator
        coordinator.applySnapshot(items: items)
        return coordinator.collectionView
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(source: source)
    }
    
    final internal class Cell: UICollectionViewCell {
        let contentTag = 10923
        
        func configure(with view: UIView) {
            viewWithTag(contentTag)?.removeFromSuperview()
            
            view.tag = contentTag
            
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
            
            leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
    @MainActor
    final internal class Coordinator: NSObject {
        let source: Datasource
        
        init(source: Datasource) {
            self.source = source
        }
        
        lazy var collectionView: UICollectionView = {
            let layout = createLeftAlignedLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
            return collectionView
        }()
        
        private lazy var datasource = makeDatasource()
        
        private func makeDatasource() -> UICollectionViewDiffableDataSource<Int, Datasource.Content> {
            return UICollectionViewDiffableDataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
                let container = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
                
                let config = UIHostingConfiguration {
                    self?.source.view(for: itemIdentifier).fixedSize()
                }
                
                container.configure(with: config.makeContentView())

                return container
            }
        }
        
        func applySnapshot(items: [Datasource.Content]) {
            var snapshot = NSDiffableDataSourceSnapshot<Int, Datasource.Content>()
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
