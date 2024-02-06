//: [Previous](@previous)

import Foundation

public enum LoadDataAction: Equatable {
    /// Initial
    case initial
    /// Reload
    case reload
    /// Load more
    case loadMore
}

/// AbstractClass
@available(iOS 13.0, *)
public protocol AsyncLoadTemplate: AnyObject {
    /// Data type
    associatedtype DataType
    /// Create async load executer
    func createAsyncLoadExecuter() -> (LoadDataAction) async throws -> DataType
    /// Will load data
    func willLoadData(behavior: LoadDataAction)
    /// Did load data
    func didLoadData(behavior: LoadDataAction, data: DataType)
    /// Failed load data
    func failedLoadData(behavior: LoadDataAction, error: Error)
}

public extension AsyncLoadTemplate {
    func willLoadData(behavior: LoadDataAction) {}
    
    func failedLoadData(behavior: LoadDataAction, error: Error) {}
    
    @discardableResult
    func loadData(_ behavior: LoadDataAction) -> Task<Void, Never> {
        Task.init { [weak self] in
            self?.willLoadData(behavior: behavior)
            guard let executer = self?.createAsyncLoadExecuter() else {
                return
            }
            do {
                let data = try await executer(behavior)
                try Task.checkCancellation()
                self?.didLoadData(behavior: behavior, data: data)
            } catch {
                self?.failedLoadData(behavior: behavior, error: error)
            }
        }
    }
}

/// ConcreteClass
final class AnyController: AsyncLoadTemplate {
    private(set) var data: Int?
    
    typealias DataType = Int
    
    func createAsyncLoadExecuter() -> (LoadDataAction) async throws -> DataType {
        { _ in
            try await Task.sleep(nanoseconds: NSEC_PER_SEC * 1)
            return Int.random(in: 0...100)
        }
    }
    
    func didLoadData(behavior: LoadDataAction, data: DataType) {
        self.data = data
    }
}

let controller = AnyController()
controller.loadData(.initial)
sleep(2)
print(controller.data)

controller.loadData(.reload)
sleep(2)
print(controller.data)

//: [Next](@next)
