//
//  Section.swift
//  AppStore-UI
//
//  Created by Artemy Ozerski on 13/07/2022.
//

import Foundation

struct Section : Codable, Hashable{
    let id : Int
    let type : String
    let title : String
    let subtitle : String
    let apps : [App]

}
