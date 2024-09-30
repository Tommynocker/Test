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
        
        let result = try await connection.execute("SELECT * FROM infor.icast_cast_order", logger: logger)
        
        var order = [OrderDTO]()
        
     
        
        
        let x = try await result.collect()
        
        x.forEach { ora in
            print("")
            let x  = ora.keyed { $0.columnName == "ANR"}.values
           
            print("")
        }
//
//        for try await row in result.collect() {
//            let x = try row.decode(String.self, forKey: "anr")
//            
//            
//            
//        }
    
      
        
//        for row in try await result.collect() {
//            
//            if let anr = row["anr"] as? String {
//                
//            }
//            
//        }
        
        
        
       
//        let x = rows.map([OrderDTO].self)
//        for try await (anr,artikel,werkst,fv,formnr,abc) in rows.decode((String,String,String,String,String,String).self) {
//          // do something with the datatypes.
//            order.append(OrderDTO(anr: anr, artikel: artikel, werkst: werkst, fv: fv, formnr: formnr, abc: abc, flgew: 0, status: nil, kw: nil, datum: nil, fis: nil))
//        }
        
        // Close your connection once done
        try await connection.close()
        
        return order
    }
     
   
    
    
}


