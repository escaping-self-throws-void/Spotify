//
//  AlbumCell.swift
//  Spotify
//
//  Created by Paul Matar on 04/12/2022.
//

import UIKit

final class AlbumCell: UICollectionViewCell {
    
    private let albumView = AlbumCellView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumView.resetImage()
    }
    
    func configure(with model: AlbumModel) {
        albumView.configure(with: model)
    }
    
    private func layoutViews() {
        albumView.place(on: contentView).pin(.allEdges)
    }
}
