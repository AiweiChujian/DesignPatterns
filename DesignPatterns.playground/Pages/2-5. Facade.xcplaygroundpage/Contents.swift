//: [Previous](@previous)
import Foundation

// Subsystem
class TV {
    func on() {
        print("打开电视机")
    }
    
    func off() {
        print("关闭电视机")
    }
}

class VoiceBox {
    func on() {
        print("打开音箱")
    }
    
    func off() {
        print("关闭音箱")
    }
}

class Light {
    func on() {
        print("打开灯光")
    }
    
    func off() {
        print("关闭灯光")
    }
}

class PlayStation {
    func on() {
        print("打开游戏机")
    }
    
    func off() {
        print("关闭游戏机")
    }
}

// Facade
class HomeFacade {
    private lazy var tv = TV()
    
    private lazy var vb = VoiceBox()
    
    private lazy var lt = Light()
    
    private lazy var ps = PlayStation()
    
    func gameMode() {
        print("游戏模式:")
        tv.on()
        vb.off()
        lt.off()
        ps.on()
    }
    
    func ktvMode() {
        print("KTV 模式:")
        tv.on()
        vb.on()
        lt.on()
        ps.off()
    }
}

// Client
let facade = HomeFacade()
facade.gameMode()
facade.ktvMode()

//: [Next](@next)
