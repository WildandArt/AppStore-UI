//
//  Sections.swift
//  AppStore-UI
//
//  Created by Artemy Ozerski on 13/07/2022.
//

import Foundation

struct App : Codable, Hashable{
    let id : Int
    let tagline : String
    let name : String
    let subheading : String
    let image : String
    let iap : Bool
}
