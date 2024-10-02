//
//  File.swift
//  
//
//  Created by Thomas Rakowski on 19.09.24.
//

import Foundation
import Vapor
import OracleNIO
import NIOCore
import NIOPosix

//@Statement("SELECT \("anr", String.self) FROM infor.icast_cast_order")
struct OrderStatemant: OraclePreparedStatement {
    
    typealias Row = (String)
    

 
//    static let sql = "SELECT anr,artikel,werkst,fv,formnr,abc, flgew, status,kw,datum,fis FROM infor.icast_cast_order"
    static let sql = "SELECT anr FROM infor.icast_cast_order"
  
    func makeBindings() throws -> OracleBindings {
           var bindings = OracleBindings(capacity: 1)
           return bindings
       }

    func decodeRow(_ row: OracleRow) throws -> Row {
           try row.decode(Row.self)
       }
//    func decodeRow(_ row: OracleRow) throws -> OrderDTO {
//        let (anr, artikel, werkst, fv, formnr, abc, flgew, status, kw, datum, fis) = try row.decode((String, String, String,String,String, String, Float, String,String,String,String).self)
//        return OrderDTO(anr: anr, artikel: artikel, werkst: werkst, fv: fv, formnr: formnr, abc: abc, flgew: flgew, status: status, kw: kw, datum: datum, fis: fis)
//    }
    
    
}


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
