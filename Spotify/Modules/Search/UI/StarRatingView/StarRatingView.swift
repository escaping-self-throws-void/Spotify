//
//  StarRatingView.swift
//  Spotify
//
//  Created by Paul Matar on 03/12/2022.
//

import UIKit

final class StarRatingView: UIView {

    private let starImageViews = (1...5).map { _ in
        let imageView = UIImageView()
        imageView.tintColor = .systemOrange
        return imageView
    }
    
    var rating: Float = 3.5 {
        didSet {
            setStarsFor(rating: rating)
        }
    }
    
    private lazy var starStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: starImageViews)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 2
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        starStack.place(on: self)
            .pin(.allEdges)
    }
    
    private func setStarsFor(rating: Float) {
        let fullStarImage = UIImage(systemName: C.Images.fullStar)
        let halfStarImage = UIImage(systemName: C.Images.halfStar)
        let emptyStarImage = UIImage(systemName: C.Images.emptyStar)
        
        (1...5).forEach { i in
            let floatI = Float(i)
            starImageViews[i-1].image = rating >= floatI-0.25
            ? fullStarImage
            : (rating >= floatI-0.75
               ? halfStarImage
               : emptyStarImage)
        }
    }
}
