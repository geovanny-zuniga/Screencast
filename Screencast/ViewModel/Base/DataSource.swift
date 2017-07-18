//
//  File.swift
//  Screencast
//
//  Created by Neil García on 7/14/17.
//  Copyright © 2017 SOIN. All rights reserved.
//

import Foundation

protocol DataSource {
    
    associatedtype type
    
    func hasData() -> Bool
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    func object(atIndex: IndexPath) -> type
}
