//: [Previous](@previous)

import Foundation

/// ObjectStructure
final class SingRobot {
    private let disk = Disk(content: "两只老虎")
    
    private let speaker = Speaker(tone: "电子音")
    
    func sing() {
        print("用[\(speaker.tone)]唱歌:《\(disk.content)》")
    }
}

final class Disk {
    var content: String
    
    init(content: String) {
        self.content = content
    }
}

final class Speaker {
    var tone: String
    
    init(tone: String) {
        self.tone = tone
    }
}

/// Visitor
protocol Visitor {
    func visit(_  disk: Disk)
    func visit(_ speaker: Speaker)
}

/// ConcreteVisitor
struct UpdateVistor: Visitor {
    func visit(_ disk: Disk) {
        disk.content = "发如雪"
    }
    
    func visit(_ speaker: Speaker) {
        speaker.tone = "拟人声"
    }
}

/// Element
protocol Visitable {
    func accept(_ visitor: Visitor)
}

/// ConcreteElement
extension Disk: Visitable {
    func accept(_ visitor: Visitor) {
        visitor.visit(self)
    }
}

extension Speaker: Visitable {
    func accept(_ visitor: Visitor) {
        visitor.visit(self)
    }
}

extension SingRobot: Visitable {
    func accept(_ visitor: Visitor) {
        disk.accept(visitor)
        speaker.accept(visitor)
    }
}

let robot = SingRobot()
robot.sing()

let updater = UpdateVistor()
robot.accept(updater)

robot.sing()

//: [Next](@next)
