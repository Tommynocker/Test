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
        
        var config = OracleConnection.Configuration(
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
        
       
            let sql = "%\(werk ?? "")%"
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
            
      
    }
}


