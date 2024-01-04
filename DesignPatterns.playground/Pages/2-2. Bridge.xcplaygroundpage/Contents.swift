//: [Previous](@previous)
import Foundation

// Abstraction
protocol HandsetType {
    var lockSolution: LockScreenSolution { set get }
    
    func lockScreen()
}

// RefinedAbstraction
class WinPhone: HandsetType {
    var lockSolution: LockScreenSolution
    
    init(_ lockSolution: LockScreenSolution) {
        self.lockSolution = lockSolution
    }
    
    func lockScreen() {
        print("WinPhone:")
        lockSolution.lock()
    }
}

class IPhone: HandsetType {
    var lockSolution: LockScreenSolution
    
    init(_ lockSolution: LockScreenSolution) {
        self.lockSolution = lockSolution
    }
    
    func lockScreen() {
        print("iPhone:")
        lockSolution.lock()
    }
}

// Implementor
protocol LockScreenSolution {
    func lock()
}

// ConcreteImplementor
class TouchID: LockScreenSolution {
    func lock() {
        print("TouchID锁屏, 通过指纹解锁")
    }
}

class LockCode: LockScreenSolution {
    func lock() {
        print("LockCode锁屏, 通过密码解锁")
    }
}

class FaceID: LockScreenSolution {
    func lock() {
        print("FaceID锁屏, 通过面容解锁")
    }
}

// Client
WinPhone(LockCode()).lockScreen()
IPhone(TouchID()).lockScreen()
IPhone(FaceID()).lockScreen()

//: ### 优缺点
//: * 对于有两个维度会发生变化的复杂类, 桥接模式将它们分别视为抽象和实现部分, 再通过组合关系桥接起来, 两部分都可以独立的修改、扩展和复用

//: [Next](@next)
