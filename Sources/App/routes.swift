import Vapor


func routes(_ app: Application) throws {
    
    // Middleware
    app.middleware.use(LogMiddleware())
    
    // register Controller
    try app.register(collection: TestController())
}
