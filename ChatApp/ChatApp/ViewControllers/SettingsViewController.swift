//
//  ThemesViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 11.10.2021.
//

import UIKit

class SettingsViewController: UIViewController {
   
    @IBOutlet var lightThemeButton: UIButton!
    @IBOutlet var darkThemeButton: UIButton!
    @IBOutlet var customThemeButton: UIButton!
    @IBOutlet var settingsLabel: UILabel!

    private var themeOne: UIColor = .white
    private var themeTwo: UIColor = .black
    private var themeThree: UIColor = .orange
    
    var closure: ((ThemeSettings) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    @IBAction func lightThemeButtonTapped(_ sender: UIButton) {
        closure?(lightTheme)
        view.backgroundColor = lightTheme.backgroundColor
        UserSettings.userTheme = "LightTheme"
    }
    
    @IBAction func darkThemeButtonTapped(_ sender: UIButton) {
        closure?(darkTheme)
        view.backgroundColor = darkTheme.backgroundColor
        UserSettings.userTheme = "DarkTheme"
    }
    
    @IBAction func customThemeButtonTapped(_ sender: UIButton) {
        closure?(customTheme)
        view.backgroundColor = customTheme.backgroundColor
        UserSettings.userTheme = "CustomTheme"
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func setupView() {
        lightThemeButton.layer.cornerRadius = 10
        darkThemeButton.layer.cornerRadius = 10
        customThemeButton.layer.cornerRadius = 10
    }
}
