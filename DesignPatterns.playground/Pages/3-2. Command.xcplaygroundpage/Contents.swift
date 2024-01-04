//: [Previous](@previous)
// 将一个请求封装为一个对象, 从而使你可用不同的请求对客户进行参数化, 对请求排队或记录请求日志, 以及支持可撤销的操作
import Foundation

// Receiver
protocol OnOffReceiver {
    func on()
    func off()
}

protocol UpDownReceiver {
    func up()
    func down()
}

class Light: OnOffReceiver {
    func on() {
        print("开灯")
    }
    
    func off() {
        print("关灯")
    }
}

class TV: OnOffReceiver, UpDownReceiver {
    func on() {
        print("打开电视")
    }
    
    func off() {
        print("关闭电视")
    }
    
    func up() {
        print("调高电视音量")
    }
    
    func down() {
        print("调低电视音量")
    }
}

// Command
protocol Command {
    func execute()
}

// ConcreteCommand
struct OnCommand: Command {
    var receiver: OnOffReceiver
    
    func execute() {
        receiver.on()
    }
}

struct OffCommand: Command {
    var receiver: OnOffReceiver
    
    func execute() {
        receiver.off()
    }
}

struct UpCommand: Command {
    var receiver: UpDownReceiver
    
    func execute() {
        receiver.up()
    }
}

struct DownCommand: Command {
    var receiver: UpDownReceiver
    
    func execute() {
        receiver.down()
    }
}

struct PartyCommand: Command {
    var commands: [Command]
    
    func execute() {
        commands.forEach { $0.execute() }
    }
}

// Invoker
class RemoteControl {
    private var commandQueue = [Command]()
    
    func take(command: Command) {
        commandQueue.append(command)
    }
    
    func process() {
        while commandQueue.count > 0 {
            let command = commandQueue.removeFirst()
            command.execute()
        }
    }
}

// Client
let light = Light()
let tv = TV()
let remoteControl = RemoteControl()

let partyCommand = PartyCommand(commands: [OnCommand(receiver: light), OnCommand(receiver: tv), UpCommand(receiver: tv)])

remoteControl.take(command: partyCommand)
remoteControl.process()

print("=========")

remoteControl.take(command: OffCommand(receiver: light))
remoteControl.take(command: OffCommand(receiver: tv))
remoteControl.process()

//: [Next](@next)
