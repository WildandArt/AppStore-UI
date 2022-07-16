//
//  SElfConfiguringCell.swift
//  AppStore-UI
//
//  Created by Artemy Ozerski on 13/07/2022.
//

import Foundation

protocol SelfConfiguringCell{
    static var reuseIdentifier : String {get}
    func configureCell(with app : App)
}
