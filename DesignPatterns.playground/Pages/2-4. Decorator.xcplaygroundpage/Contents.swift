//: [Previous](@previous)
import Foundation

// Component
protocol CarComponent {
    func show()
}

// ConcreteComponent
class Benz: CarComponent {
    func show() {
        print("这是一辆奔驰")
    }
}

// Decorator
protocol CarDecorator: AnyObject, CarComponent {
    var component: CarComponent? { get set }
}

extension CarDecorator {
    func decorate(_ compoent: CarComponent) {
        self.component = compoent
    }
}
// ConcreteDecorator
class GPS: CarDecorator {
    var component: CarComponent?
    
    func show() {
        component?.show()
        print("安装了 GPS")
    }
}

class Powertrain: CarDecorator {
    var component: CarComponent?
    
    func show() {
        component?.show()
        engine()
        gearbox()
    }
    
    func engine() {
        print("2.0T 发动机")
    }
    
    func gearbox() {
        print("8AT 变速箱")
    }
}

// Client
let car = Benz()
let gps = GPS()
let pt = Powertrain()

gps.decorate(car)
pt.decorate(gps)

pt.show()

// 链式扩展
extension CarComponent {
    func decorated(by decorator: CarDecorator) -> CarDecorator {
        decorator.component = self
        return decorator
    }
}

Benz().decorated(by: GPS()).decorated(by: Powertrain()).show()

//: [Next](@next)
