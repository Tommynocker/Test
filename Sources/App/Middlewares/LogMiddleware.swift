//
//  Untitled.swift
//  Test
//
//  Created by Thomas Rakowski on 07.10.24.
//


import Foundation
import Vapor

struct LogMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        
//        guard request.headers.basicAuthorization.username == "thomas" else {
//            let response = Response(status: .unauthorized)
//            return try await next.respond(to: response)
//        }
//        
        
        
        print("LOG Middleware")
        return try await next.respond(to: request)
    }
    
    
    
}
