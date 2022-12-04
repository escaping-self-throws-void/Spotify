//
//  AlbumCell.swift
//  Spotify
//
//  Created by Paul Matar on 04/12/2022.
//

import UIKit

final class AlbumCell: UICollectionViewCell {
    
    private let albumView = AlbumCellView()

    private lazy var previewButton: UIButton = {
        let bttn = UIButton(type: .custom)
        bttn.backgroundColor = .systemGreen
        bttn.layer.cornerRadius = 10
        bttn.layer.borderWidth = 1
        bttn.layer.borderColor = UIColor.black.cgColor
        let title = NSAttributedString(
            string: C.Text.preview,
            attributes: [.foregroundColor: UIColor.black,
                         .font: UIFont.systemFont(ofSize: 8, weight: .bold)]
        )
        bttn.setAttributedTitle(title, for: .normal)
        bttn.contentMode = .center
        let buttonAction = UIAction { [weak self] _ in
            self?.onButtonClick?(self?.stringURL ?? "")
        }
        bttn.addAction(buttonAction, for: .touchUpInside)
        return bttn
    }()
    
    var onButtonClick: StringClosure?
    
    private var stringURL: String?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumView.resetImage()
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func configure(with model: AlbumModel) {
        albumView.configure(with: model)
        stringURL = model.externalLink
    }
    
    private func layoutViews() {
        albumView.place(on: contentView).pin(.allEdges)
        
        previewButton.place(on: self).pin(
            .bottom(padding: 3),
            .trailing(padding: 3),
            .fixedWidth(90)
        )
    }
}
