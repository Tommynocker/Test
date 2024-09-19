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
    
    /// <#Description#>
    /// - Parameter routes: <#routes description#>
    func boot(routes: RoutesBuilder) throws {
        
        let route = routes.grouped("api")
        
        route.get("order", use: getOrder)
    }
    
    // post register
    func getOrder(req: Request)async throws -> [OrderDTO] {
        
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
        
        let rows = try await connection.execute("SELECT * FROM infor.icast_cast_order", logger: logger)
        
        var order = [OrderDTO]()
        
//        for try await row in rows{
//            
//            let x = row.decode(OrderDTO.self)
//            order.append(x)
//        }
        
        
        for try await (anr) in rows.decode((String).self) {
          // do something with the datatypes.
            order.append(OrderDTO(anr: anr))
        }
        
        // Close your connection once done
        try await connection.close()
        
        return order
    }
     
   
    
    
}


