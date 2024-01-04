//: [Previous](@previous)

/// Mediator
protocol ProgramMediator: AnyObject {
    func dispatchDesignTask(_ task: String)
    
    func dispatchDevelopTask(_ task: String)
}

/// Concrete Mediator
final class ProjectManager: ProgramMediator {
    
    var designer: Designer!
    
    var developer: Developer!
    
    func setup(_ designer: Designer, _ developer: Developer) {
        self.designer = designer
        self.developer = developer
    }
    
    func dispatchDesignTask(_ task: String) {
        designer.start(task)
    }
    
    func dispatchDevelopTask(_ task: String) {
        developer.start(task)
    }
    
    func take(task: String) {
        dispatchDesignTask(task)
        dispatchDevelopTask(task)
    }
}

/// Colleague1
final class Designer {
    private unowned let mediator: ProgramMediator
    
    init(mediator: ProgramMediator) {
        self.mediator = mediator
    }
    
    func start(_ task: String) {
        print("完成\"\(task)\"的 UI 设计")
    }
    
    func take(task: String) {
        start(task)
        mediator.dispatchDevelopTask(task)
    }
}

/// Colleague2
final class Developer {
    private unowned let mediator: ProgramMediator
    
    init(mediator: ProgramMediator) {
        self.mediator = mediator
    }
    
    func start(_ task: String) {
        print("完成\"\(task)\"的程序开发")
    }
    
    func take(task: String) {
        mediator.dispatchDesignTask(task)
        start(task)
    }
}

let pm = ProjectManager()
let ui = Designer(mediator: pm)
let dev = Developer(mediator: pm)
pm.setup(ui, dev)

pm.take(task: "主页")
ui.take(task: "活动页")
dev.take(task: "IM")

//: [Next](@next)
