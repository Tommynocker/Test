import Vapor


func routes(_ app: Application) throws {
    // register Controller
    try app.register(collection: TestController())
}
