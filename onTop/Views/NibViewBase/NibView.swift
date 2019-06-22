//
//  NibView.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

private let nibViewTag = 666013

protocol NibView {
    /// the view instantiated from nib (will be populated by commonInit)
    var rootView: UIView? { get }
    
    /// the parent view that implements the protocol
    var parentView: UIView { get }
    
    var nibName: String { get }
    var bundle: Bundle { get }
    func commonInit()
}

extension NibView where Self: UIView {
    var rootView: UIView? {
        for subview in parentView.subviews {
            if subview.tag == nibViewTag {
                return subview
            }
        }

        return nil
    }
    
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
        parentView.addSubview(nibView)
        NSLayoutConstraint.activate(
            [
                nibView.widthAnchor.constraint(equalTo: parentView.widthAnchor),
                nibView.heightAnchor.constraint(equalTo: parentView.heightAnchor),
                nibView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
                nibView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
            ]
        )
        
        nibView.tag = nibViewTag
    }
}

