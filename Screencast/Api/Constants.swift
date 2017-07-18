//
//  Constants.swift
//  ScreencastList
//
//  Created by Neil García on 7/13/17.
//  Copyright © 2017 SOIN. All rights reserved.
//

import UIKit

class Constants: NSObject {
    static let url = "https://www.nsscreencast.com"
    static let port = 443
    static let port2 = 80
    static let urlLogin = "http://screencast.getsandbox.com"
    
    static var fullURL: String {
        return "\(url):\(port)"
    }
    
    static var fullURLLogin: String {
        return "\(urlLogin):\(port2)"
    }
}
