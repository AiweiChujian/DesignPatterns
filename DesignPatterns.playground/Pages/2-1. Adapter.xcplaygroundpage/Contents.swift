//: [Previous](@previous)
import Foundation

// Target
protocol NBAPlayer {
    var name: String { get }
    
    func attack()
    
    func defense()
}

// Adaptee
class ChinesePlayer {
    init (lastName: String, firstName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    let firstName: String
    let lastName: String
    
    func 进攻() {
        print("\(lastName)\(firstName)进攻")
    }
    
    func 防守() {
        print("\(lastName)\(firstName)防守")
    }
}

// Adapter
class Translator: NBAPlayer {
    init(player: ChinesePlayer) {
        chinesePlayer = player
    }
    
    let chinesePlayer: ChinesePlayer
    
    var name: String {
        "\(chinesePlayer.lastName)\(chinesePlayer.firstName)"
    }
    
    func attack() {
        chinesePlayer.进攻()
    }
    
    func defense() {
        chinesePlayer.防守()
    }
}

// Other Target
class AmericanPlayer: NBAPlayer {
    init(name: String) {
        self.name = name
    }
    
    let name: String
    
    func attack() {
        print("\(name) attack")
    }
    
    func defense() {
        print("\(name) defense")
    }
}

// Client
let yaoming = ChinesePlayer(lastName: "姚", firstName: "明")
let kobe = AmericanPlayer(name: "Kobe")

let team: [NBAPlayer] = [kobe, Translator(player: yaoming)]

print("开始进攻...")
team.forEach { $0.attack() }

print("转为防守...")
team.forEach { $0.defense() }

//: [Next](@next)
