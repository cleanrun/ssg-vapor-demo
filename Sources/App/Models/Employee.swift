import Fluent
import Vapor

final class Employee: Model, Content {
    static let schema = "employees"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Field(key: "address")
    var address: String

    init() { }

    init(id: UUID? = nil, name: String, address: String) {
        self.id = id
        self.name = name
        self.address = address
    }
}

extension Employee {
    static func create(from data: EmployeeCreate) -> Employee {
        Employee(name: data.name, address: data.address)
    }
}
