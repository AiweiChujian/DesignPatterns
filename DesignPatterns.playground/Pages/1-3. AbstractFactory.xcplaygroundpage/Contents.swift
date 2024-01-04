//: [Previous](@previous)

import Foundation

// AbstractProduct
protocol User {
    var name: String { get set }
    
    func printInfo()
}

protocol Department {
    var title: String { get set }
    
    func printInfo()
}

// AbstractFactory
protocol DBModelFactory {
    func createUser(with name: String) -> User
    
    func createDepartment(with title: String) -> Department
}

// ConcreteProduct
struct SQLUser: User {
    var name: String
    
    func printInfo() {
        print("SQL User: \(name)")
    }
}

struct SQLDepartment: Department {
    var title: String
    
    func printInfo() {
        print("SQL Department: \(title)")
    }
}

struct AccessUser: User {
    var name: String
    
    func printInfo() {
        print("Access User: \(name)")
    }
}

struct AccessDepartment: Department {
    var title: String
    
    func printInfo() {
        print("Aceess Department: \(title)")
    }
}

// ConcreteFacotry
class SQLFactory: DBModelFactory {
    func createUser(with name: String) -> User {
        SQLUser(name: name)
    }
    
    func createDepartment(with title: String) -> Department {
        SQLDepartment(title: title)
    }
}

class AccessFactory: DBModelFactory {
    func createUser(with name: String) -> User {
        AccessUser(name: name)
    }
    
    func createDepartment(with title: String) -> Department {
        AccessDepartment(title: title)
    }
}

// Client
let factory1 = SQLFactory()
factory1.createUser(with: "小明").printInfo()
factory1.createDepartment(with: "研发部").printInfo()

let factory2 = AccessFactory()
factory2.createUser(with: "小红").printInfo()
factory2.createDepartment(with: "财务部").printInfo()

//: [Next](@next)
