//: [Previous](@previous)
import Foundation

// Component
protocol Component: AnyObject {
    var title: String { get }
    
    var children: [Component] { get set }
}

extension Component {
    func add(_ child: Component) {
        children.append(child)
    }
    
    func remove(_ child: Component) {
        guard let index = children.firstIndex(where: {$0 === child}) else {
            return
        }
        children.remove(at: index)
    }
    
    func display(with prefix: String = "") {
        print(prefix + title)
        
        let indent = prefix.replacingOccurrences(of: "┠", with: "┃").replacingOccurrences(of: "┗", with: " ") + "  "
        for (index, child) in children.enumerated() {
            if index == children.count - 1 {
                child.display(with: indent + "┗ ")
            } else {
                child.display(with: indent + "┠ ")
            }
        }
    }
}

// Composite & Leaf
class RecursiveMenu: Component {
    init(title: String) {
        self.title = title
    }
    
    let title: String
    
    var children =  [Component] ()
}

// Client
let zg = RecursiveMenu(title: "中国")

let sichuan = RecursiveMenu(title: "四川")
zg.add(sichuan)

let chengdu = RecursiveMenu(title: "成都")
sichuan.add(chengdu)

let wuhong = RecursiveMenu(title: "武侯")
chengdu.add(wuhong)

let gaoxin = RecursiveMenu(title: "高新")
chengdu.add(gaoxin)

let  nanchong = RecursiveMenu(title: "南充")
sichuan.add(nanchong)

let jialing = RecursiveMenu(title: "嘉陵")
nanchong.add(jialing)


let xizang = RecursiveMenu(title: "西藏")
zg.add(xizang)

let lasa = RecursiveMenu(title: "拉萨")
xizang.add(lasa)

zg.add(RecursiveMenu(title: "海南"))

zg.display()

//: [Next](@next)
