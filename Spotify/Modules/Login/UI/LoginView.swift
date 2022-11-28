//
//  LoginView.swift
//  Spotify
//
//  Created by Paul Matar on 28/11/2022.
//

import UIKit

final class LoginView: UIView {
    
    private lazy var icon: UIImageView = {
        let iv = UIImageView()
        iv.image = .init(named: C.Images.spotify)
        iv.backgroundColor = .white
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 25
        return iv
    }()
    
    private lazy var introLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = C.Text.millionsOfSongs
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 22, weight: .bold)
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var loginButton: UIButton = {
        let bttn = UIButton(type: .custom)
        bttn.backgroundColor = .systemGreen
        bttn.layer.cornerRadius = 20
        let title = NSAttributedString(
            string: C.Text.login,
            attributes: [.foregroundColor: UIColor.black,
                         .font: UIFont.systemFont(ofSize: 14, weight: .bold)]
        )
        bttn.setAttributedTitle(title, for: .normal)
        
        let buttonAction = UIAction { [weak self] _ in
            self?.onButtonClick?()
        }
        bttn.addAction(buttonAction, for: .touchUpInside)
        return bttn
    }()
    
    var onButtonClick: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initialize()
    }
    
    private func initialize() {
        icon.pin(
            .fixedWidth(50),
            .fixedHeight(50)
        )
        
        loginButton.pin(
            .fixedHeight(40),
            .fixedWidth(bounds.width - 40)
        )
        
        let stack = UIStackView(arrangedSubviews: [icon, introLabel, loginButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .fillProportionally
        
        stack.place(on: self).pin(
            .centerY,
            .leading(padding: 20),
            .trailing(padding: 20),
            .fixedHeight(200)
        )
    }
}
