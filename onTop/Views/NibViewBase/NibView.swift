//
//  NibView.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol NibView {
    var nibName: String { get }
    var bundle: Bundle { get }
    func commonInit()
}

extension NibView where Self: UIView {
    
    var nibName: String {
        return String(describing: type(of: self))
    }
    
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func commonInit() {
        let nib = UINib(nibName: nibName, bundle: bundle)
        let nibObjects = nib.instantiate(withOwner: self, options: nil)
        guard let nibView = nibObjects.first as? UIView else {
            fatalError("Expected a view as first element in .xib")
        }
        
        nibView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nibView)
        NSLayoutConstraint.activate(
            [
                nibView.widthAnchor.constraint(equalTo: widthAnchor),
                nibView.heightAnchor.constraint(equalTo: heightAnchor),
                nibView.centerXAnchor.constraint(equalTo: centerXAnchor),
                nibView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
    }
}

