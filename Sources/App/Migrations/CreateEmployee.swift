import Fluent

struct CreateEmployee: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("employees")
            .id()
            .field("name", .string, .required)
            .field("address", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("employees").delete()
    }
}
