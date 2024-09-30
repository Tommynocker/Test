//
//  File.swift
//  
//
//  Created by Thomas Rakowski on 19.09.24.
//

import Foundation
import Vapor
import OracleNIO



public struct OrderDTO: Codable, Content {
    
    public var anr: String?
    public var artikel: String?
    public var werkst: String?
    public var fv: String?
    public var formnr: String?
    public var abc: String?
    public var flgew: Int
    public var status: String?
    public var kw: String?
    public var datum: String?
    public var fis: String?
    
    init(anr: String?, artikel: String?, werkst: String?, fv: String?, formnr: String?, abc: String?, flgew: Int,status: String?,kw: String?,datum: String?, fis: String?) {
        self.anr = anr
        self.artikel = artikel
        self.werkst = werkst
        self.fv = fv
        self.formnr = formnr
        self.abc = abc
        self.flgew = flgew
        self.status = status
        self.kw = kw
        self.datum = datum
        self.fis = fis
    }
}

