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
    
    var settingsClosure: ((ThemeSettings) -> Void)?

    private var themeOne: UIColor = .white
    private var themeTwo: UIColor = .black
    private var themeThree: UIColor = .orange
    private let particleAnimation = ParticleAnimation()
    
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let gestureRecognizer = UIPanGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(touchTracking(sender:)))
        return gestureRecognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    @IBAction func lightThemeButtonTapped(_ sender: UIButton) {
        settingsClosure?(lightTheme)
        view.backgroundColor = lightTheme.backgroundColor
        ThemeManager.userTheme = lightTheme.themeName
    }
    
    @IBAction func darkThemeButtonTapped(_ sender: UIButton) {
        settingsClosure?(darkTheme)
        view.backgroundColor = darkTheme.backgroundColor
        ThemeManager.userTheme = darkTheme.themeName
    }
    
    @IBAction func customThemeButtonTapped(_ sender: UIButton) {
        settingsClosure?(customTheme)
        view.backgroundColor = customTheme.backgroundColor
        ThemeManager.userTheme = customTheme.themeName
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func touchTracking(sender: UIPanGestureRecognizer) {
        particleAnimation.touchTracking(sender: sender, view: view)
    }
    
    private func setupView() {
        lightThemeButton.layer.cornerRadius = 10
        darkThemeButton.layer.cornerRadius = 10
        customThemeButton.layer.cornerRadius = 10
        view.addGestureRecognizer(panGestureRecognizer)
    }
}
