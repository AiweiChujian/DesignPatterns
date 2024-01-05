//: [Previous](@previous)

/// Originator
final class Editor {
    private var content: String
    
    init(_ content: String = "") {
        self.content = content
    }
    
    var mementoHandler: ((_ memento: Memento) -> Void)?
    
    func backup() -> Memento {
        Memento(text: content)
    }
    
    func resume(_ memento: Memento) {
        content = memento.text
    }
    
    func input(_ char: Character) {
        content.append(char)
        mementoHandler?(backup())
    }
}

extension Editor: CustomStringConvertible {
    var description: String {
        content
    }
}

/// Memento
extension Editor {
    struct Memento: Codable {
        fileprivate let text: String
    }
}

/// Caretaker
var caretaker: [Editor.Memento] = []

let editor = Editor()

editor.mementoHandler = {
    caretaker.append($0)
}

editor.input("备")
editor.input("忘")
editor.input("录")
print(editor)

editor.resume(caretaker.removeLast())
print(editor)
editor.resume(caretaker.removeLast())
print(editor)
editor.resume(caretaker.removeLast())
print(editor)

//: [Next](@next)
