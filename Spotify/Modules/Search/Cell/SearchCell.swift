//
//  SearchCell.swift
//  Spotify
//
//  Created by Paul Matar on 03/12/2022.
//

import UIKit

final class SearchCell: UICollectionViewCell {
    
    private let searchView = SearchCellView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        searchView.resetImage()
    }
    
    func configure(with model: ArtistModel) {
        searchView.configure(with: model)
    }
    
    private func layoutViews() {
        searchView.place(on: contentView).pin(.allEdges)
    }
}
