//: [Previous](@previous)

import Foundation

// Product
protocol MobilePhone {
    var ram: Int { get }
    
    var rom: Int { get }
    
    init(ram: Int, rom: Int)
    
    func printInfo()
}

// ConcreteProduct 1
struct IPhone: MobilePhone {
    var ram: Int = 3
    var rom: Int = 64
    
    func printInfo() {
        print("iPhone: \(ram)G内存, \(rom)G硬盘")
    }
}

// ConcreteProduct 2
struct Huawei: MobilePhone {
    var ram: Int = 8
    var rom: Int = 128
    
    func printInfo() {
        print("huaiwei: \(ram)G内存, \(rom)G硬盘")
    }
}

// Creator
protocol MobilePhoneFactory {
    func createMobilePhone(ram: Int, rom: Int) -> MobilePhone
}

// ConcreteCreator 1
class AppleFactory: MobilePhoneFactory {
    func createMobilePhone(ram: Int, rom: Int) -> MobilePhone {
        IPhone(ram: ram, rom: rom)
    }
}

// ConcreteCreator 2
class HuaweiFactory: MobilePhoneFactory {
    func createMobilePhone(ram: Int, rom: Int) -> MobilePhone {
        Huawei(ram: ram, rom: rom)
    }
}

// Client
let mobile1 = AppleFactory().createMobilePhone(ram: 4, rom: 128)
mobile1.printInfo()

let mobile2 = HuaweiFactory().createMobilePhone(ram: 16, rom: 512)
mobile2.printInfo()

//: [Next](@next)
