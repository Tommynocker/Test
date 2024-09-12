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

struct TestController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        
        let route = routes.grouped("api", "consumer")
        
        route.get("test", use: test)
    }
    
    // post register
    func test(req: Request) async throws -> String {
        
        // config oracle
        let logger = Logger(label: "oracle-logger")
        
        let config = OracleConnection.Configuration(
            host: "172.20.1.36",
            port: 12002,
            service: .serviceName("Test77"), // or .sid("sid")
            username: "infor",
            password: "sysm"
        )
        
        let connection = try await OracleConnection.connect(
          configuration: config,
          id: 1,
          logger: logger
        )
        
        let rows = try await connection.execute("SELECT werkstoff,sollstk FROM infor.apltsaegen", logger: logger)
        
        
        print(rows)
        var x = "zonk"
        for try await (werkstoff, sollstk) in rows.decode((String, Float).self) {
          // do something with the datatypes.
             x = werkstoff
            let y = sollstk
            print("")
        }
        
        
        return x
    }
     
   
    
    
}


