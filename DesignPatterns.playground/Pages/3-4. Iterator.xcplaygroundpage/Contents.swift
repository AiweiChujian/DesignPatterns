//: [Previous](@previous)
// 提供一种方法顺序访问一个聚合对象中各个元素, 而又不需暴露该对象的内部表示

import Foundation

// Iterator
protocol AbstractIterator {
    associatedtype Element
    
    mutating func next() -> Self.Element?
}

// ConcreteIterator
/// 正序迭代器
struct ObverseIterator<Element> {
    let aggregate: ListAggregate<Element>
    
    private(set) var nextIndex = 0
}

extension ObverseIterator: AbstractIterator {
    mutating func next() -> Element? {
        guard nextIndex < aggregate.count else {
            return nil
        }
        defer { nextIndex += 1}
        return aggregate[nextIndex]
    }
}

/// 随机迭代器
struct RandomIterator<Element> {
    let aggregate: ListAggregate<Element>
    
    private(set) lazy var shuffledList: [Element] = aggregate.list.shuffled()
    
    private(set) var nextIndex = 0
}

extension RandomIterator: AbstractIterator {
    mutating func next() -> Element? {
        guard nextIndex < shuffledList.count else {
            return nil
        }
        defer { nextIndex += 1}
        return shuffledList[nextIndex]
    }
}

// Aggregate
protocol Aggregate {
    associatedtype Iterator: AbstractIterator
    associatedtype Element where Self.Element == Self.Iterator.Element
    
    func createIterator() -> Self.Iterator
}

// ConcreteAggregate
class ListAggregate<Element>: ExpressibleByArrayLiteral {
    private(set) var list = Array<Element>()
    
    required init(arrayLiteral elements: Element...) {
        list = Array(elements)
    }
    
    var count: Int { list.count }
    
    subscript(index: Int) -> Element {
        get { list[index] }
        set { list[index] = newValue }
    }
}

extension ListAggregate: Aggregate {
//    func createIterator() -> ObverseIterator<Element> {
//        ObverseIterator(aggregate: self)
//    }
    
    func createIterator() -> RandomIterator<Element> {
        RandomIterator(aggregate: self)
    }
}

// Client
let numbers: ListAggregate<Int> = [2, 3, 5, 7, 9, 17, 22]

var numbersIterator = numbers.createIterator()

while let num = numbersIterator.next() {
    print(num)
}

print("first: \(numbers[0])")

//: [Next](@next)


