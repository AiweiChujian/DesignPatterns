//: [Previous](@previous)

import Foundation

/// Strategy
protocol ErrorHandlerType: AnyObject {
    func handle(error: Error)
}

/// ConcreteStrategy
final class DebugErrorHandler: ErrorHandlerType {
    func handle(error: Error) {
        print("Show alert for error: \(error.localizedDescription)")
    }
}

final class ReleaseErrorHandler: ErrorHandlerType {
    func handle(error: Error) {
        print("Write error to log file: \(error.localizedDescription)")
    }
}

/// Context
final class Controller {
    let errorHandler: ErrorHandlerType
    
    init(_ errorHandler: ErrorHandlerType) {
        self.errorHandler = errorHandler
    }
    
    func request() {
        do {
            // NSLocalizedDescriptionKey, NSUnderlyingErrorKey
            throw NSError(domain: "com.dp.test", code: -1, userInfo: [NSLocalizedDescriptionKey: "请求出错!"])
        } catch {
            errorHandler.handle(error: error)
        }
    }
}

/// Client

let debugController = Controller(DebugErrorHandler())
debugController.request()

let releaseController = Controller(ReleaseErrorHandler())
releaseController.request()

//: [Next](@next)
