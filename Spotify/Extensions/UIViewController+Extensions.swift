//
//  UIViewController+Extensions.swift
//  Spotify
//
//  Created by Paul Matar on 04/12/2022.
//

import UIKit

extension UIViewController {
    func dismissKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
