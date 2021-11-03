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
    
    var settingsClosure: ((ThemeSettings) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    @IBAction func lightThemeButtonTapped(_ sender: UIButton) {
        settingsClosure?(lightTheme)
        view.backgroundColor = lightTheme.backgroundColor
        ThemeManager.userTheme = "LightTheme"
//        SaveUserTheme.saveUserTheme(userTheme: Theme(themeName: "LightTheme")) for GCD method
    }
    
    @IBAction func darkThemeButtonTapped(_ sender: UIButton) {
        settingsClosure?(darkTheme)
        view.backgroundColor = darkTheme.backgroundColor
        ThemeManager.userTheme = "DarkTheme"
//        SaveUserTheme.saveUserTheme(userTheme: Theme(themeName: "DarkTheme")) for GCD method
    }
    
    @IBAction func customThemeButtonTapped(_ sender: UIButton) {
        settingsClosure?(customTheme)
        view.backgroundColor = customTheme.backgroundColor
        ThemeManager.userTheme = "CustomTheme"
//        SaveUserTheme.saveUserTheme(userTheme: Theme(themeName: "CustomTheme")) for GCD method
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
