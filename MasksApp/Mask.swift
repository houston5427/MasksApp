//
//  Mask.swift
//  MasksApp
//
//  Created by Glen Lin on 2020/2/15.
//  Copyright © 2020 Glen Lin. All rights reserved.
//

import Foundation

struct Mask:Codable {
    var id:String
    var name:String
    var address:String
    var tel:String
    var adult:String
    var child:String
    var time:Date
    
    
    enum CodingKeys: String, CodingKey  {
        case id = "醫事機構代碼"
        case name = "醫事機構名稱"
        case address = "醫事機構地址"
        case tel = "醫事機構電話"
        case adult = "成人口罩剩餘數"
        case child = "兒童口罩剩餘數"
        case time = "來源資料時間"
    }
    
    

}
