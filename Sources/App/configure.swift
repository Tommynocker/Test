import Vapor
import OracleNIO

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

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
    
    for try await (werkstoff, sollstk) in rows.decode((String, Float).self) {
      // do something with the datatypes.
        let x = werkstoff
        let y = sollstk
        print("")
    }
    
    
    
//    for try await row in rows {
//      // do something with the row
//
//        print("")
//    }

    // Close your connection once done
    try await connection.close()
    
    
    
    // register routes
    try routes(app)
}
