//
//  ThemeSettings.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 11.10.2021.
//

import UIKit

struct ThemeSettings {
    
    var themeName: String
    var backgrounColor: UIColor
    var fontColor: UIColor

static func themeChanging(selectedTheme: ThemeSettings) {
    
    UITableView.appearance().backgroundColor = selectedTheme.backgrounColor
    UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: selectedTheme.fontColor]
    UINavigationBar.appearance().backgroundColor = selectedTheme.backgrounColor
    UINavigationBar.appearance().barTintColor = selectedTheme.backgrounColor
    UINavigationBar.appearance().tintColor = selectedTheme.fontColor
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: selectedTheme.fontColor]
    }
}

var lightTheme: ThemeSettings = ThemeSettings(
    themeName: "LightTheme",
    backgrounColor: .white,
    fontColor: .black
)
var darkTheme: ThemeSettings = ThemeSettings(
    themeName: "DarkTheme",
    backgrounColor: .black,
    fontColor: .white
)
var customTheme: ThemeSettings = ThemeSettings(
    themeName: "CustomTheme",
    backgrounColor: .orange,
    fontColor: .white
)
