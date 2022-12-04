//
//  WelcomeView.swift
//  Spotify
//
//  Created by Paul Matar on 04/12/2022.
//

import UIKit

final class WelcomeView: UIView {
    
    private lazy var mainLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = C.Text.find
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 22, weight: .bold)
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var minorLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = C.Text.search
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .systemGray
        lbl.textAlignment = .center
        return lbl
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutViews()
    }
    
    private func layoutViews() {
        let stack = UIStackView(arrangedSubviews: [mainLabel, minorLabel])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .fillProportionally
        
        stack.place(on: self).pin(.allEdges)
    }
}
