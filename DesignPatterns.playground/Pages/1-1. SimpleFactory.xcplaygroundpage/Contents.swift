//: [Previous](@previous)

import Foundation

// Abstract Product
protocol Operation {
    var numberA: Double { get set }
    var numberB: Double { get set }
    func getResult() -> Double
}

// ConcreteProduct 1
struct OperationAdd: Operation {
    var numberA: Double
    var numberB: Double
    func getResult() -> Double {
        numberA + numberB
    }
}

// ConcreteProduct 2
struct OperationSub: Operation {
    var numberA: Double
    var numberB: Double
    func getResult() -> Double {
        numberA - numberB
    }
}

// ConcreteProduct 3
struct OperationMul: Operation {
    var numberA: Double
    var numberB: Double
    func getResult() -> Double {
        numberA * numberB
    }
}

// ConcreteProduct 4
struct OperationDiv: Operation {
    var numberA: Double
    var numberB: Double
    func getResult() -> Double {
        if numberB == 0 {
            return Double.nan
        }
        return numberA / numberB
    }
}

// Factory
class OperationFactory {
    enum Operate: String {
        case add = "+"
        case sub = "-"
        case mul = "*"
        case div = "/"
    }
    
    static func creatOperation(_ operate: Operate) -> Operation {
        switch operate {
        case .add:
            return OperationAdd(numberA: 0, numberB: 0)
        case .sub:
            return OperationSub(numberA: 0, numberB: 0)
        case .mul:
            return OperationMul(numberA: 0, numberB: 0)
        case .div:
            return OperationDiv(numberA: 0, numberB: 0)
        }
    }
}

// Client
var op = OperationFactory.creatOperation(.div)
op.numberA = 20
op.numberB = 5
print(op.getResult())

//: ### 优缺点
//: * 工厂类需要知道所有产品的信息, 不利于扩展, 不符合开闭原则

//: [Next](@next)
