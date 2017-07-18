//
//  MEpisode.swift
//  Screencast
//
//  Created by Neil García on 7/14/17.
//  Copyright © 2017 SOIN. All rights reserved.
//

import UIKit
import ObjectMapper
/// Episode model to represent episode data.
struct MEpisode: Mappable {
    var number = 0
    var title = ""
    var description = ""
    var duration = 0
    var primaryColor = ""
    var smallArtwork: URL?
    var largeArtwork: URL?
    var image: URL?
    var tags = [String]()
    var videoURL: URL?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        number <- map["episode_number"]
         title <- map["title"]
         description <- map["description"]
         duration <- map["duration"]
         primaryColor <- map["dominant_color"]
         smallArtwork <- (map["small_artwork_url"], URLTransform())
         largeArtwork <- (map["large_artwork_url"], URLTransform())
         image <- (map["artwork_imgix_url"], URLTransform())
         tags <- map["tags"]
         videoURL <- (map["video_url"], URLTransform())
        
    }
}
