//
//  CollectionViewController.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import UIKit
import SwiftUI

class CollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLeftAlignedLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    private lazy var datasource = makeDatasource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        applySnapshot()
    }
    
    private func makeDatasource() -> UICollectionViewDiffableDataSource<Int, String> {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            
            let config = UIHostingConfiguration {
                OptionView(option: ActivityOption(id: "", text: itemIdentifier, emoji: nil)).toggleStyle(ChipToggleStyle())
            }
            
            let label = config.makeContentView()
            label.translatesAutoresizingMaskIntoConstraints = false
            
            cell.addSubview(label)
            
            cell.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
            cell.topAnchor.constraint(equalTo: label.topAnchor).isActive = true
            cell.trailingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
            cell.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
            
            return cell
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([1])
        snapshot.appendItems(["hello","world","welcom","to","wonderful","awesome","layout","using","__________","this","spectacular","collection","view","hiyahhh"])
        
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

struct rep: UIViewRepresentable {
    let controller = CollectionViewController()
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> some UIView {
        return controller.view
    }
}
