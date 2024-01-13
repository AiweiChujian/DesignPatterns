//: [Previous](@previous)

import AVFoundation

/// State
protocol PlayerStateType: AnyObject {
    func primaryAction()
    /// Optional
    func handleInterruptBegan()
    func handleInterruptEnded()
}

extension PlayerStateType {
    func handleInterruptBegan() {}
    func handleInterruptEnded() {}
}

/// Context
final class PlayerManager {
    var state: PlayerStateType? {
        didSet { state?.primaryAction() }
    }
    
    func handleInterruptNotification(_ interruptType: AVAudioSession.InterruptionType) {
        switch interruptType {
        case .began:
            state?.handleInterruptBegan()
        case .ended:
            state?.handleInterruptEnded()
        }
    }
}

/// ConcreteState
final class PlayState: PlayerStateType {
    private(set) unowned var manager: PlayerManager
    
    init?(_ manager: PlayerManager) {
        self.manager = manager
    }
    
    func handleInterruptBegan() {
        print("打断播放")
        manager.state = InterruptState(manager)
    }
    
    func primaryAction() {
        print("player: 播放")
    }
    
}

class PauseState: PlayerStateType {
    private(set) unowned var manager: PlayerManager
    
    init?(_ manager: PlayerManager) {
        self.manager = manager
    }
    
    func primaryAction() {
        print("player: 暂停")
    }
    
    func handleInterruptEnded() {}
}

final class InterruptState: PauseState {
    override func handleInterruptEnded() {
        print("恢复播放")
        manager.state = PlayState(manager)
    }
}

/// Client
let manager = PlayerManager()

manager.handleInterruptNotification(.began)
manager.state = PlayState(manager)

manager.handleInterruptNotification(.ended)
manager.handleInterruptNotification(.began)
manager.handleInterruptNotification(.ended)

//: [Next](@next)
