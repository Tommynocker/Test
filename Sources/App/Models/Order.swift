//
//  File.swift
//  
//
//  Created by Thomas Rakowski on 19.09.24.
//

import Foundation
import Vapor
import OracleNIO
import OracleNIOMacros


struct OrderStatemant {
    
    struct Row {
            var id: Int
            var name: String
            var age: Int
        }

        static let sql = "SELECT id, name, age FROM users WHERE :1 < age"
        
        var age: OracleNumber

        func makeBindings() throws -> OracleBindings {
            var bindings = OracleBindings(capacity: 1)
            bindings.append(age, context: .default, bindName: "1")
            return bindings
        }

        func decodeRow(_ row: OracleRow) throws -> Row {
            let (id, name, age) = try row.decode((Int, String, Int).self)
            return Row(id: id, name: name, age: age)
        }
//    static let sql = "SELECT anr FROM infor.icast_cast_order"
  
    
    
}

extension OrderStatemant: OraclePreparedStatement {}


struct OrderDTO: Codable, Content {
    
    public var anr: String?
    public var artikel: String?
    public var werkst: String?
    public var fv: String?
    public var formnr: String?
    public var abc: String?
    public var flgew: Float
    public var status: String?
    public var kw: String?
    public var datum: String?
    public var fis: String?
    
    init(anr: String?, artikel: String?, werkst:String?, fv: String?, formnr: String?, abc: String?, flgew: Float, status: String?, kw: String?, datum: String?, fis: String?) {
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
    
    enum CodingKeys: String, CodingKey {
        case anr = "ANR"
        case artikel = "ARTIKEL"
        case werkst = "WERKST"
        case fv = "FV"
        case formnr = "FORMNR"
        case abc = "ABC"
        case flgew = "FLGEW"
        case status = "STATUS"
        case kw = "KW"
        case datum = "DATUM"
        case fis = "FIS"
    }
}
