//
//  AlbumCellView.swift
//  Spotify
//
//  Created by Paul Matar on 04/12/2022.
//

import UIKit

final class AlbumCellView: UIView {
    
    private lazy var imageView: AsyncImageView = {
        let iv = AsyncImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.alpha = 0.6
        return iv
    }()
    
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 10, weight: .bold)
        lbl.textAlignment = .justified
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var artistsLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 8, weight: .bold)
        lbl.textAlignment = .justified
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var releaseLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 10)
        lbl.textAlignment = .justified
        return lbl
    }()
    
    private lazy var trackLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 10)
        lbl.textAlignment = .justified
        return lbl
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutViews()
    }
    
    func configure(with model: AlbumModel) {
        let placeholder = UIImage(named: C.Images.placeholder)
        imageView.setImage(model.image, placeholder: placeholder)
        nameLabel.text = model.name
        artistsLabel.text = model.artists
        releaseLabel.text = model.releaseYear
        trackLabel.text = model.totalTracks
    }
    
    func resetImage() {
        imageView.image = nil
    }
    
    private func layoutViews() {
        imageView.place(on: self).pin(.allEdges)

        nameLabel.place(on: self).pin(
            .leading(padding: 3),
            .trailing(padding: 20),
            .top(padding: 3)
        )
        let stack = UIStackView(arrangedSubviews: [artistsLabel,
                                                   trackLabel,
                                                   releaseLabel])
        stack.axis = .vertical
        stack.spacing = 1
        stack.place(on: self).pin(
            .leading(padding: 3),
            .trailing,
            .bottom(padding: 3)
        )
    }
}
