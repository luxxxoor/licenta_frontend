//
//  ChangeEmailVC.swift
//  onTop
//
//  Created by Alexandru Vrincean on 04/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class ChangeEmailVC: UIViewController, StoryboardViewController {
    @IBOutlet private weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackButton()
    }
    
    private func setupBackButton() {
        backButton.setImage(#imageLiteral(resourceName: "right_arrow-icon"), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        backButton.titleLabel?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        backButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
