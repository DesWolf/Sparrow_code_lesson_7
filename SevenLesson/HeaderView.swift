//
//  HeaderView.swift
//  SevenLesson
//
//  Created by Максим Окунеев on 21.07.2023.
//

import UIKit

class HeaderView: UIView {
    public let headerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "frogs"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    private var containerView = UIView()
    private var containerHeight = NSLayoutConstraint()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
        setViewsConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews() {
        addSubview(containerView)
        containerView.addSubview(headerImageView)
    }
     
    func setViewsConstraint() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.widthAnchor.constraint(equalTo: headerImageView.widthAnchor).isActive = true
        containerHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerHeight.isActive = true
        
        imageViewBottom = headerImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBottom.isActive = true
        
        imageViewHeight = headerImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeight.isActive = true
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        containerHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
 
}
