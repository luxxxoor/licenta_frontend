//
//  StoryboardViewController.swift
//  onTop
//
//  Created by Alexandru Vrincean on 07/04/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol StoryboardViewController {
    static func instantiate(from storyboard: UIStoryboard, withIdentifier identifier: String) -> Self
}

extension StoryboardViewController where Self: UIViewController {
    
    static func instantiate(
        from storyboard: UIStoryboard = .main,
        withIdentifier identifier: String = String(describing: Self.self)) -> Self {
        
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}

