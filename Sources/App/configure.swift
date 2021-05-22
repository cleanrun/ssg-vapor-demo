import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    app.databases.use(.postgres(
        hostname: "localhost",
        username: "postgres",
        password: "",
        database: "ssgdemo"
    ), as: .psql)

    app.migrations.add(CreateEmployee())

    // register routes
    try routes(app)
}
