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
        observerList.list = observerList.list.filter{
            $0.observer !== observer
        }
    }
}


/// Subject

/// ConcreteSubject
<#具体的目标, 在状态发生改变时, 通知各个观察者#>

/// ConcreteObserver
<#具体的观察者, 实现更新接口, 使自身状态与目标状态保持一致#>


//: [Next](@next)

