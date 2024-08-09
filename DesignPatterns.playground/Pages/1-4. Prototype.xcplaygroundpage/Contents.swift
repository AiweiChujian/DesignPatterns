//: [Previous](@previous)
import Foundation

// Prototype
protocol Copiable: AnyObject {
    func copy() -> Self
}

// ConcretePrototype
class Resume: Copiable {
    required init() {}
    
    var name: String = "--"
    var sex: String = "--"
    var age: Int = 0
    
    func copy() -> Self {
        let temp = Self()
        temp.name = name
        temp.sex = sex
        temp.age = age
        return temp
    }
}

class Vitae: Resume {
    var company: String = "--"
    
    override func copy() -> Self {
        let temp = super.copy()
        temp.company = company
        return temp
    }
}

// Client
let cv1 = Vitae()
cv1.name = "小何"
cv1.company = "小卖部"

let cv2 = cv1.copy()
cv2.company = "理发店"

print(cv1.name)
print(cv1.company)
print(cv2.name)
print(cv2.company)

//: [Next](@next)
