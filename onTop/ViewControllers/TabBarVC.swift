//
//  TabBarVC.swift
//  onTop
//
//  Created by Alexandru Vrincean on 09/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController, StoryboardViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = UIColor.CustomColors.systemBlue
    }
}
