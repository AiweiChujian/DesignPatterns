//: [Previous](@previous)
import Foundation

// Product
class House {
    var wall: String?
    
    var window: String?
    
    var door: String?
    
    func printInfo() {
        print("房子:")
        print(wall ?? "")
        print(window ?? "没有窗户")
        print(door ?? "")
        print("")
    }
}

// Builder
protocol HouseBuilder {
    var house: House { get }
    
    func buildWall(height: String)
    
    func buildWindow(count: Int)
    
    func buildDoor(count: Int)
}

// ConcreteBuilder
class CabinBuilder: HouseBuilder {
    var house: House = .init()
    
    func buildWall(height: String) {
        // Cabin 使用木墙
        house.wall = "\(height)的木墙"
    }
    
    func buildWindow(count: Int) {
        // Cabin 使用木窗
        house.window = "\(count)面木窗"
    }
    
    func buildDoor(count: Int) {
        // Cabin 使用木门
        house.door = "\(count)扇木门"
    }
}

class VillaBuilder: HouseBuilder {
    var house: House = .init()
    
    func buildWall(height: String) {
        // Villa 使用砖墙
        house.wall = "\(height)的砖墙"
    }
    
    func buildWindow(count: Int) {
        // Villa 使用玻璃窗
        house.window = "\(count)面玻璃窗"
    }
    
    func buildDoor(count: Int) {
        // Villa 使用铁门
        house.door = "\(count)扇铁门"
    }
}

// Director
class HouseDirector {
    static func createStandardHouse(builder: HouseBuilder) -> House {
        builder.buildWall(height: "高大")
        builder.buildWindow(count: 4)
        builder.buildDoor(count: 2)
        return builder.house
    }
    
    static func createSmallHouse(builder: HouseBuilder) -> House {
        // 小房子, 没有窗子
        builder.buildWall(height: "低矮")
        builder.buildDoor(count: 1)
        return builder.house
    }
}

// Client
let house1 = HouseDirector.createStandardHouse(builder: CabinBuilder())
house1.printInfo()

let house2 = HouseDirector.createStandardHouse(builder: VillaBuilder())
house2.printInfo()

let house3 = HouseDirector.createSmallHouse(builder: CabinBuilder())
house3.printInfo()

let house4 = HouseDirector.createSmallHouse(builder: VillaBuilder())
house4.printInfo()


//: [Next](@next)
