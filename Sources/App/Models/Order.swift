//
//  File.swift
//  
//
//  Created by Thomas Rakowski on 19.09.24.
//

import Foundation
import Vapor



public struct OrderDTO: Codable, Content {
    
    public var anr: String?
    
    init(anr: String?) {
        self.anr = anr
    }
}

