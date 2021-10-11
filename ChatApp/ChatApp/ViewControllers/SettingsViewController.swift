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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    @IBAction func lightThemeButtonTapped(_ sender: UIButton) {
    }
    @IBAction func darkThemeButtonTapped(_ sender: UIButton) {
    }
    @IBAction func customThemeButtonTapped(_ sender: UIButton) {
    }
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func setupView() {
        lightThemeButton.layer.cornerRadius = 10
        darkThemeButton.layer.cornerRadius = 10
        customThemeButton.layer.cornerRadius = 10
    }
    
    private func logThemeChanging(selectedTheme: UIColor) {
    }
}
