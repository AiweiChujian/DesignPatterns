//: [Previous](@previous)
import Foundation

// Singleton
class Singleton {
    static let shared = Singleton()

    private init () {}
    
    var title: String = ""
}

// Client
let s = Singleton.shared
s.title = "今日头条"

Singleton.shared.title = "昨日黄花"

print(s.title)

//: [Next](@next)
