//: [Previous](@previous)
// 给定一个语言, 定义它的文法的一种表示, 并定义一个解释器, 这个解释器使用该表示来解释语言中的句子

import Foundation

// AbstractExpression
protocol Expression {
    func interpret(info: String) -> Bool
}

// TerminalExpression
struct TerminalExpression: Expression {
    var keyWords: [String]
    
    func interpret(info: String) -> Bool {
        keyWords.contains(info)
    }
}

// NonterminalExpression
struct AndExpression: Expression {
    var cityExpresiion: TerminalExpression
    
    var roleExpression: TerminalExpression
    
    func interpret(info: String) -> Bool {
        let substrings = info.components(separatedBy: "的")
        return cityExpresiion.interpret(info: substrings[0]) && roleExpression.interpret(info: substrings[1])
    }
}

// Context
class Context {
    private let citys = ["成都", "重庆"]
    
    private let roles = ["老人", "小孩", "残疾人"]
    
    private lazy var freeExpression: Expression = {
        let expression = AndExpression(cityExpresiion: .init(keyWords: citys), roleExpression: .init(keyWords: roles))
        return expression
    }()
    
    func busRide(info: String) {
        if freeExpression.interpret(info: info) {
            print("您是\(info), 本次乘车免费")
        } else {
            print("您是\(info), 需要支付车费2元")
        }
    }
}

// Client
let context = Context()
context.busRide(info: "成都的小孩")
context.busRide(info: "重庆的残疾人")
context.busRide(info: "重庆的青年")
context.busRide(info: "北京的老人")

//: [Next](@next)

