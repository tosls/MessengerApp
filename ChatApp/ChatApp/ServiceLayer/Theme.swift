//
//  ThemesModel.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 11.10.2021.
//

import UIKit

struct Theme: Codable {
    
    var themeName: String?
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
