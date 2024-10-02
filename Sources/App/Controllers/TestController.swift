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


struct TestController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        
        let route = routes.grouped("api")
        
        route.get("order", use: getOrder)
    }
    
    // post register
    @Sendable
    func getOrder(req: Request) async throws -> [OrderDTO] {
        
        // config oracle
        let logger = Logger(label: "oracle-logger")
        
        let config = OracleConnection.Configuration(
            host: "172.20.1.36",
            port: 12002,
            service: .serviceName("Test77"),
            username: "infor",
            password: "sysm"
        )
        
        let connection = try await OracleConnection.connect(
          configuration: config,
          id: 1,
          logger: logger
        )
        
        let stream = try await connection.execute("SELECT anr,artikel,werkst,fv,formnr,abc, flgew, status,kw,datum,fis FROM infor.icast_cast_order", logger: logger)
        
        var order = [OrderDTO]()
        for try await (anr, artikel, werkst, fv, formnr, abc, flgew, status,kw,datum,fis) in stream.decode((String, String, String,String,String, String, Float, String,String,String,String).self) {
            order.append(.init(anr: anr, artikel: artikel, werkst: werkst, fv:fv, formnr: formnr, abc: abc, flgew: flgew, status: status, kw: kw, datum: datum, fis: fis ))
        }
        
        // Close your connection once done
        try await connection.close()
        return order
    }
}


