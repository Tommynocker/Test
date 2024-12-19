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
            var stk_v: Int
            var kg_v: Int
            var stk_l: Int
            var kg_l: Int
            var bedarfe_stk: Int
            var verbr12_kg: Int
            var ktxt: String
            var bemerkung: String?
            var variante: String
            var gueltigkeit: String
            var verbrauchq1: Int
            var verbrauchq2: Int
            var verbrauchq3: Int
        }

        static let sql = "SELECT mnr, werkstoff,staerke,stk_v,kg_v,stk_l,kg_l,bedarfe_stk,verbr12_kg,ktxt,bemerkung,variante,gueltigkeit,verbrauchq1,verbrauchq2,verbrauchq3 FROM US_BLZ_ARTIKELKONTO_WXZ WHERE werkstoff like :1"
    
//    WHERE :1 = werkstoff
        
        let werkstoff: String

        func makeBindings() throws -> OracleBindings {
            var bindings = OracleBindings(capacity: 1)
            bindings.append(werkstoff, context: .default, bindName: "1")
            return bindings
        }

        func decodeRow(_ row: OracleRow) throws -> Row {
            let (mnr, werkstoff, staerke, stk_v, kg_v, stk_l, kg_l,bedarfe_stk, verbr12_kg, ktxt, bemerkung, variante, gueltigkeit, verbrauchq1, verbrauchq2,verbrauchq3) = try row.decode((String, String, Float, Int, Int, Int, Int, Int, Int, String, String, String, String, Int, Int, Int).self)
            return Row(mnr: mnr, werkstoff: werkstoff, staerke: staerke, stk_v: stk_v, kg_v: kg_v, stk_l: stk_l, kg_l: kg_l,bedarfe_stk: bedarfe_stk,verbr12_kg: verbr12_kg,ktxt: ktxt,bemerkung: bemerkung,variante: variante,gueltigkeit: gueltigkeit,verbrauchq1: verbrauchq1, verbrauchq2: verbrauchq2,verbrauchq3: verbrauchq3)
        }
}

extension USBLZWXZ: OraclePreparedStatement {}


struct WXZDTO: Codable, Content {
    
    public var mnr: String
    public var werkstoff: String
    public var staerke: Float
    public var stk_v: Int
    public var kg_v: Int
    public var stk_l: Int
    public var kg_l: Int
    public var bedarfe_stk: Int
    public var verbr12_kg: Int
    public var ktxt: String
    public var bemerkung: String?
    public var variante: String
    public var gueltigkeit: String
    public var verbrauchq1: Int
    public var verbrauchq2: Int
    public var verbrauchq3: Int
    
    init(mnr: String, werkstoff: String, staerke: Float, stk_v: Int, kg_v: Int, stk_l: Int, kg_l: Int, bedarfe_stk: Int, verbr12_kg: Int, ktxt: String, bemerkung: String, variante: String, gueltigkeit: String, verbrauchq1: Int, verbrauchq2: Int, verbrauchq3: Int) {
        self.mnr = mnr
        self.werkstoff = werkstoff
        self.staerke = staerke
        self.stk_v = stk_v
        self.kg_v = kg_v
        self.stk_l = stk_l
        self.kg_l = kg_l
        self.bedarfe_stk = bedarfe_stk
        self.verbr12_kg = verbr12_kg
        self.ktxt = ktxt
        self.bemerkung = bemerkung
        self.variante = variante
        self.gueltigkeit = gueltigkeit
        self.verbrauchq1 = verbrauchq1
        self.verbrauchq2 = verbrauchq2
        self.verbrauchq3 = verbrauchq3
    }
    
    enum CodingKeys: String, CodingKey {
        case mnr = "MNR"
        case werkstoff = "WERKSTOFF"
        case staerke = "STAERKE"
        case stk_v = "STK_V"
        case kg_v = "KG_V"
        case stk_l = "STK_L"
        case kg_l = "KG_L"
        case bedarfe_stk = "BEDARFE_STK"
        case verbr12_kg = "VERBR12_KG"
        case ktxt = "KTXT"
        case bemerkung = "BEMERKUNG"
        case variante = "VARIANTE"
        case gueltigkeit = "GUELTIGKEIT"
        case verbrauchq1 = "VERBRAUCHQ1"
        case verbrauchq2 = "VERBRAUCHQ2"
        case verbrauchq3 = "VERBRAUCHQ3"
    }
}
