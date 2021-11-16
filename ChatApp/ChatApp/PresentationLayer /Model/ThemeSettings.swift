//
//  ThemeSettings.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 11.10.2021.
//

import UIKit

struct ThemeSettings {
    
    var themeName: String
    var backgroundColor: UIColor
    var fontColor: UIColor

static func themeChanging(selectedTheme: ThemeSettings) {
    
    UITableView.appearance().backgroundColor = selectedTheme.backgroundColor
    
    UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: selectedTheme.fontColor]
    UINavigationBar.appearance().backgroundColor = selectedTheme.backgroundColor
    UINavigationBar.appearance().barTintColor = selectedTheme.backgroundColor
    UINavigationBar.appearance().tintColor = selectedTheme.fontColor
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: selectedTheme.fontColor]
    }
    
}

var lightTheme: ThemeSettings = ThemeSettings(
    themeName: "LightTheme",
    backgroundColor: .white,
    fontColor: .black
)
var darkTheme: ThemeSettings = ThemeSettings(
    themeName: "DarkTheme",
    backgroundColor: .black,
    fontColor: .white
)
var customTheme: ThemeSettings = ThemeSettings(
    themeName: "CustomTheme",
    backgroundColor: .orange,
    fontColor: .white
)
