import Vapor

func routes(_ app: Application) throws {
        app.get { req async in
        "It works! Version2"
    }

    app.get("hello") { req async -> String in
        "Hello, world! Yes"
    }
}
