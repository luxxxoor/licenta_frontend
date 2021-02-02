//
//  SettingsTabVC.swift
//  onTop
//
//  Created by Alexandru Vrincean on 22/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

protocol SettingTabVCDelegate: AnyObject {
    func settingTabVCDidTapOnCheckSubscriptions(_ settingTabVC: SettingTabVC)
    func settingTabVCDidTapOnChangeEmail(_ settingTabVC: SettingTabVC)
    func settingTabVCDidTapOnChangePassword(_ settingTabVC: SettingTabVC)
    func settingTabVCDidTapOnLogout(_ settingTabVC: SettingTabVC)
}

class SettingTabVC: UIViewController, StoryboardViewController {
    
    weak var delegate: SettingTabVCDelegate?
    
    @IBAction private func didTapCheckSubscriptions(_ sender: UIButton) {
        delegate?.settingTabVCDidTapOnCheckSubscriptions(self)
    }
    
    @IBAction private func didTapChangeEmail(_ sender: UIButton) {
        delegate?.settingTabVCDidTapOnChangeEmail(self)
    }
    
    @IBAction private func didTapChangePassword(_ sender: UIButton) {
        delegate?.settingTabVCDidTapOnChangePassword(self)
    }
    
    @IBAction private func didTapLogout(_ sender: UIButton) {
        delegate?.settingTabVCDidTapOnLogout(self)
    }
}
