//
//  MEpisodeResponse.swift
//  Screencast
//
//  Created by Neil García on 7/14/17.
//  Copyright © 2017 SOIN. All rights reserved.
//

import UIKit
import ObjectMapper

struct MEpisodeResponse: Mappable {
    var episodes: [MEpisode] = [MEpisode]()
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        episodes <- map["episodes"]
        
    }
}
