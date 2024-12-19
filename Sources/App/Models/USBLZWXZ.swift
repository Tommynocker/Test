//
//  File.swift
//  Test
//
//  Created by Thomas Rakowski on 17.12.24.
//

import Foundation
import Vapor
import OracleNIO
import OracleNIOMacros


struct USBLZWXZ {
    
        struct Row {
            var mnr: String
            var werkstoff: String
            var staerke: Float
        }

        static let sql = "SELECT mnr, werkstoff, staerke FROM US_BLZ_ARTIKELKONTO_WXZ WHERE werkstoff like :1"
    
//    WHERE :1 = werkstoff
        
        let werkstoff: String

        func makeBindings() throws -> OracleBindings {
            var bindings = OracleBindings(capacity: 1)
            bindings.append(werkstoff, context: .default, bindName: "1")
            return bindings
        }

        func decodeRow(_ row: OracleRow) throws -> Row {
            let (mnr, werkstoff, staerke) = try row.decode((String, String, Float).self)
            return Row(mnr: mnr, werkstoff: werkstoff, staerke: staerke)
        }
}

extension USBLZWXZ: OraclePreparedStatement {}


struct WXZDTO: Codable, Content {
    
    public var mnr: String
    public var werkstoff: String
    public var staerke: Float
    
    init(mnr: String, werkstoff: String, staerke: Float) {
        self.mnr = mnr
        self.werkstoff = werkstoff
        self.staerke = staerke
    }
    
    enum CodingKeys: String, CodingKey {
        case mnr = "MNR"
        case werkstoff = "WERKSTOFF"
        case staerke = "STAERKE"
    }
}
