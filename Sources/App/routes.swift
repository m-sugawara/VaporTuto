import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // GET /users
    router.get("users", Int.parameter) { req -> String in
        let userId = try req.parameters.next(Int.self)
        return "requested user id: #\(userId)"
    }

    // POST /search_todo
    router.post("search") { req -> Future<[Todo]> in
        let sampleTodos = [
            Todo(id: 1, title: "a"),
            Todo(id: 2, title: "b"),
            Todo(id: 3, title: "a"),
            Todo(id: 4, title: "b"),
            Todo(id: 5, title: "a"),
            Todo(id: 6, title: "b")
        ]
        return try! req.content.decode(SearchTodoRequest.self).map(to: [Todo].self) { searchTodoRequest in
            return sampleTodos.filter { $0.id == searchTodoRequest.id }
        }
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
