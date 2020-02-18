//
//  MaskAnnotationStruct.swift
//  MasksApp
//
//  Created by Glen Lin on 2020/2/16.
//  Copyright © 2020 Glen Lin. All rights reserved.
//

import Foundation

struct MaskAnnotationStruct:Decodable {
    let name: String
    let phone: String
    let address: String
    let maskAdult: Int
    let maskChild: Int
    let updated: Date
    let available: String
    let note: String
    let customNote: String
    let website: String
    let county: String
    let town: String
    let cunli: String
    let servicePeriods: String
}
