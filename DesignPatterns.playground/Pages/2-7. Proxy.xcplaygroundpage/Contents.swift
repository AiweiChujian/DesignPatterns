//: [Previous](@previous)
import Foundation

// Subject
protocol Subject {
    func recieve(gift: String)
}

// RealSubject
struct SchoolGirl: Subject {
    let name: String
    
    func recieve(gift: String) {
        print("\(name)收到\(gift)")
    }
}

// Proxy
class Proxy: Subject {
    let sb: Subject
    
    init(girlName: String) {
        sb = SchoolGirl(name: girlName)
    }
    
    func recieve(gift: String) {
        sb.recieve(gift: gift)
    }
}

// Client
let proxy = Proxy(girlName: "小美")
proxy.recieve(gift: "鲜花")
proxy.recieve(gift: "玩偶")

//: [Next](@next)
