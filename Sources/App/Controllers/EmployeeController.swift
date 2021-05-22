import Fluent
import Vapor

struct EmployeeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("employee")
        
        group.post("create", use: create)
        group.get("get", use: get)
        group.delete("delete", use: delete)
    }
    
    private func create(_ req: Request) throws -> EventLoopFuture<Employee> {
        let create = try req.content.decode(EmployeeCreate.self)
        let employee = Employee.create(from: create)
        
        return employee.save(on: req.db).flatMapThrowing {
            employee
        }
    }
    
    private func get(_ req: Request) throws -> EventLoopFuture<[Employee]> {
        Employee.query(on: req.db).all().flatMapThrowing { data in
            data
        }
    }
    
    private func delete(_ req: Request) throws -> EventLoopFuture<String> {
        let id = try req.content.decode(EmployeeDelete.self)
        return Employee.query(on: req.db).filter(\.$id == id.id).delete().flatMapThrowing {
            "Delete successful"
        }
    }
}

struct EmployeeCreate: Content {
    var name: String
    var address: String
}

struct EmployeeDelete: Content {
    var id: UUID
}
