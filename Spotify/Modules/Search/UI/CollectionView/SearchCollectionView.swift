//
//  SearchCollectionView.swift
//  Spotify
//
//  Created by Paul Matar on 03/12/2022.
//

import UIKit

final class SpotifyCollectionView: UICollectionView {

    private let searchLayout: UICollectionViewCompositionalLayout = {

        let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), padding: 5)
                
        
        let vGroup = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(0.5), height: .fractionalHeight(1), item: item, count: 2)
                
        let portraitGroup = CompositionalLayout.createGroup(alignment: .horizontal,
                                                            width: .fractionalWidth(1),
                                                            height: .fractionalHeight(0.45),
                                                            item: item, count: 2)
        
        let landscapeGroup = CompositionalLayout.createGroup(alignment: .horizontal,
                                                     width: .fractionalWidth(1),
                                                     height: .fractionalHeight(0.55),
                                                     items: [vGroup, vGroup])
        
        let mainGroup = CompositionalLayout.createGroup(alignment: .vertical,
                                                        width: .fractionalWidth(1),
                                                        height: .fractionalHeight(0.6),
                                                        items: [portraitGroup, landscapeGroup])
        
        let section = NSCollectionLayoutSection(group: mainGroup)
        section.interGroupSpacing = 30
                
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: searchLayout)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        keyboardDismissMode = .onDrag
        backgroundColor = .clear
    }
}
