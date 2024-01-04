//: [Previous](@previous)
// 使多个对象都有机会处理请求, 从而避免请求的发送者和接收者之间的耦合关系. 将这些对象连成一条链, 并沿着这条链传递该请求, 直到有一个对象处理它为止
import Foundation

// Handler
protocol Manager: AnyObject {
    var superior: Manager? { get set }
    
    func raiseRequest(_ dollar: Double)
}

// ConcreteHandler
class BranchManager: Manager {
    var superior: Manager?
    
    func raiseRequest(_ dollar: Double) {
        if dollar <= 1_000 {
            print("请求加薪\(dollar)美元,和部门经理谈")
        } else {
            superior?.raiseRequest(dollar)
        }
    }
}

class Majordomo: Manager {
    var superior: Manager?
    
    func raiseRequest(_ dollar: Double) {
        if dollar > 1_000, dollar <= 10_000 {
            print("请求加薪\(dollar)美元, 和总监谈")
        } else {
            superior?.raiseRequest(dollar)
        }
    }
}

class President: Manager {
    var superior: Manager?
    
    func raiseRequest(_ dollar: Double) {
        if dollar > 10_000, dollar < 100_000 {
            print("请求加薪\(dollar)美元, 和总裁谈")
        } else {
            print("请求加薪\(dollar)美元, 被忽视")
        }
    }
}

// Client
let leader = BranchManager()
leader.superior = Majordomo()
leader.superior?.superior = President()

leader.raiseRequest(800)
leader.raiseRequest(5000)
leader.raiseRequest(20000)
leader.raiseRequest(2000000)


//: [Next](@next)
