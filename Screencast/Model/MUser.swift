//
//  MUser.swift
//  Screencast
//
//  Created by Geovanny Zuniga on 17/7/17.
//  Copyright © 2017 SOIN. All rights reserved.
//

import UIKit
import ObjectMapper

struct MUser: Mappable {
    
    var userName: String = ""
    var name: String = ""
    var lastName: String = ""
    var password: String = ""
    var age: Int = 0
    var email: String = ""
    
    init(userName: String, name:String, lastName:String, password: String, age: Int, email:String) {
        self.userName = userName
        self.name = name
        self.lastName = lastName
        self.password = password
        self.age = age
        self.email = email
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        lastName <- map["lastname"]
        age <- map["age"]
        email <- map["email"]
        
    }
}
