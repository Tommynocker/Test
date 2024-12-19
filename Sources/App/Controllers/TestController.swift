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
                dataWXZ.append(.init(mnr: data.mnr, werkstoff: data.werkstoff, staerke: data.staerke))
            }
            
            
//            if let stream = stream {
//                for try await (mnr, werkstoff, staerke) in stream.decode((String, String, Float).self) {
//                    dataWXZ.append(.init(mnr: mnr, werkstoff: werkstoff, staerke: staerke))
//                }
//            }
            
            try await connection.close()
            return dataWXZ
            
        } else {
            let stream = try? await connection.execute("SELECT mnr, werkstoff, staerke FROM US_BLZ_ARTIKELKONTO_WXZ", logger: logger)
            
            var dataWXZ = [WXZDTO]()
            if let stream = stream {
                for try await (mnr, werkstoff, staerke) in stream.decode((String, String, Float).self) {
                    dataWXZ.append(.init(mnr: mnr, werkstoff: werkstoff, staerke: staerke))
                }
            }
            
            try await connection.close()
            return dataWXZ
        }
    
    }
}


