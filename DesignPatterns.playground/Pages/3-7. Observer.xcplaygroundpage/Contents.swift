//: [Previous](@previous)

import Foundation

/// Observer
protocol ObserverType: AnyObject {
    associatedtype T
    
    func subjectDidUpdate<T>(_ state: T)
}

struct ObserverList {
    fileprivate struct WeakObserver {
        weak var observer: (any ObserverType)?
    }
    
    fileprivate var list: [WeakObserver] = []
    
    static func instance() -> Self {
        .init()
    }
}

/// Subject
protocol SubjectType: ObserverType {
    var observerList: ObserverList { get set }
    
    var currentState: T { get }
}

extension SubjectType {
    func subjectDidUpdate<T>(_ state: T) {}
}

extension SubjectType {
    private func cleanObserverList() {
        observerList.list = observerList.list.filter { $0.observer != nil }
    }
    
    func notify() {
        cleanObserverList()
        observerList.list.forEach {
            $0.observer?.subjectDidUpdate(currentState)
        }
    }
    
    func attach<O: ObserverType>(_ observer: O) where O.T == T  {
        observerList.list.append(.init(observer: observer))
    }
    
    func deattach<O: ObserverType>(_ observer: O) where O.T == T {
        observerList.list = observerList.list.filter {
            $0.observer !== observer
        }
    }
}

/// ConcreteSubject
final class Noticeboard: SubjectType {
    var content: String = "" {
        didSet { notify() }
    }
    
    typealias T = String
    
    var observerList: ObserverList = .instance()
    
    var currentState: String {
        content
    }
}


/// ConcreteObserver
final class Teacher: ObserverType {
    let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    typealias T = String
    
    func subjectDidUpdate<T>(_ state: T) {
        print("教师\(name)收到通知:\(state)")
    }
}

final class Student: ObserverType {
    let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    typealias T = String
    
    func subjectDidUpdate<T>(_ state: T) {
        print("学生\(name)收到通知:\(state)")
    }
}


/// Use case
let noticeboard = Noticeboard()

let teacher = Teacher("老李")
noticeboard.attach(teacher)

let student = Student("小明")
noticeboard.attach(student)


noticeboard.content = "这周五放假"

noticeboard.deattach(teacher)
noticeboard.content = "下周一也放假"

//: [Next](@next)

