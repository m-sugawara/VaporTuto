import Vapor
import Fluent

/// Controls basic CRUD operations on `Todo`s.
final class TodoController {
    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> Future<[Todo]> {
        return Todo.query(on: req).all()
    }

    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> Future<Todo> {
        return try req.content.decode(Todo.self).flatMap { todo in
            return todo.save(on: req)
        }
    }

    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Todo.self).flatMap { todo in
            return todo.delete(on: req)
        }.transform(to: .ok)
    }

    /// Returns filtered Todos with the requested query
    func search(_ req: Request) throws -> Future<[Todo]> {
        return try! req.content.decode(SearchTodoRequest.self).flatMap(to: [Todo].self) { searchTodoRequest in
            let query = searchTodoRequest.query
            return Todo.query(on: req).filter(\.title == query).all()
        }
    }
}
