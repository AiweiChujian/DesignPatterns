//: [Previous](@previous)
import Foundation

// Flyweight
protocol BikeFlyweight {
    // 内部状态
    var isUsing: Bool { get set }
    // 外部状态
    func ride(userName: String)
    
    func back()
}

// ConcreteFlyweight
class MobikeFlyweight: BikeFlyweight {
    let id: Int
    
    init(bikeId: Int) {
        id = bikeId
    }
    
    var isUsing = false
    
    func ride(userName: String) {
        isUsing = true
        print("\(userName)骑\(id)号摩拜单车")
    }
    
    func back() {
        isUsing = false
    }
}

// FlyweightFactory
class BikeFlyweightFactory {
    static let shared = BikeFlyweightFactory()
    
    private init() {
        for idx in 1 ... 2 {
            pool.append(MobikeFlyweight(bikeId: idx))
        }
    }

    private var pool = [BikeFlyweight]()
    
    func rentBike() -> BikeFlyweight? {
        pool.first { !$0.isUsing }
    }
}

// Client
if let bike = BikeFlyweightFactory.shared.rentBike() {
    bike.ride(userName: "张三")
}

if let bike = BikeFlyweightFactory.shared.rentBike() {
    bike.ride(userName: "李四")
    bike.back()
}

if let bike = BikeFlyweightFactory.shared.rentBike() {
    bike.ride(userName: "王五")
}

if let bike = BikeFlyweightFactory.shared.rentBike() {
    bike.ride(userName: "赵六")
}

//: [Next](@next)
