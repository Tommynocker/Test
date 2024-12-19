//
//  File.swift
//  
//
//  Created by Thomas Rakowski on 12.09.24.
//

import Foundation
import Vapor
import Fluent
import OracleNIO
import Logging
import OracleNIOMacros


struct OrderStatement {}


struct TestController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        
        let route = routes.grouped("api")
        
        route.get("wxz", use: getWXZ)
        
    }
    
    // post register
    @Sendable
    func getWXZ(req: Request) async throws -> [WXZDTO] {
        
        // config oracle
        let logger = Logger(label: "oracle-logger")
        
        let config = OracleConnection.Configuration(
            host: "172.20.1.36",
            port: 12002,
            service: .serviceName("Test77"),
            username: "INFOR",
            password: "sysm"
        )
        
        let connection = try await OracleConnection.connect(
          configuration: config,
          id: 1,
          logger: logger
        )
        
        let werk = try? req.query.get(String.self, at: "werkstoff")
        
        if let paraWerk = werk {
            let sql = "%\(paraWerk)%"
            let stream = try await connection.execute(USBLZWXZ(werkstoff: sql), logger: logger)
            
            var dataWXZ = [WXZDTO]()
            for try await data in stream {
                dataWXZ.append(.init(mnr: data.mnr, werkstoff: data.werkstoff, staerke: data.staerke, stk_v: data.stk_v, kg_v: data.kg_v, stk_l: data.stk_l, kg_l: data.kg_l, bedarfe_stk: data.bedarfe_stk, verbr12_kg: data.verbr12_kg, ktxt: data.ktxt, bemerkung: data.bemerkung ?? "", variante: data.variante, gueltigkeit: data.gueltigkeit, verbrauchq1: data.verbrauchq1, verbrauchq2: data.verbrauchq2, verbrauchq3: data.verbrauchq3))
            }
            print("")
            
//            if let stream = stream {
//                for try await (mnr, werkstoff, staerke) in stream.decode((String, String, Float).self) {
//                    dataWXZ.append(.init(mnr: mnr, werkstoff: werkstoff, staerke: staerke))
//                }
//            }
            
            try await connection.close()
            return dataWXZ
            
        } else {
            let stream = try? await connection.execute("SELECT mnr, werkstoff,staerke,stk_v,kg_v,stk_l,kg_l,bedarfe_stk,verbr12_kg,ktxt,bemerkung,variante,gueltigkeit,verbrauchq1,verbrauchq2,verbrauchq3 FROM US_BLZ_ARTIKELKONTO_WXZ", logger: logger)
            
            var dataWXZ = [WXZDTO]()
            if let stream = stream {
                for try await (mnr, werkstoff, staerke, stk_v, kg_v, stk_l, kg_l, bedarfe_stk, verbr12_kg, ktxt, bemerkung, variante, gueltigkeit, verbrauchq1, verbrauchq2, verbrauchq3) in stream.decode((String, String, Float, Int, Int, Int, Int, Int, Int, String, String, String, String, Int, Int, Int).self) {
                    dataWXZ.append(.init(mnr: mnr, werkstoff: werkstoff, staerke: staerke, stk_v: stk_v, kg_v: kg_v, stk_l: stk_l, kg_l: kg_l, bedarfe_stk: bedarfe_stk, verbr12_kg: verbr12_kg, ktxt: ktxt, bemerkung: bemerkung, variante: variante, gueltigkeit: gueltigkeit, verbrauchq1: verbrauchq1, verbrauchq2: verbrauchq2, verbrauchq3: verbrauchq3))
                }
            }
            
            try await connection.close()
            return dataWXZ
        }
    
    }
}


