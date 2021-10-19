//
//  OperationsManager.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 17.10.2021.
//

import UIKit

class OperationsManager {
    private let queue = OperationQueue()
    
    func saveProfile(userData: UserProfileModel, completion: @escaping (Result<Bool, Error>) -> Void ) {
        let saveOperation = saveUserProfileOperation(userProfile: userData)
        
        saveOperation.completionBlock = {
            OperationQueue.main.addOperation {
                if let result = saveOperation.result {
                    completion(result)
                } else {
                    print("Error")
                }
            }
        }
        queue.addOperation(saveOperation)
    }
}

class AsyncOperation: Operation {
    
    enum State: String {
        case ready, executing, finished, cancelled
        
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
}

extension AsyncOperation {
    
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override var isCancelled: Bool {
        return state == .cancelled
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        main()
        state = .executing
    }
    
    override func cancel() {
        state = .cancelled
    }
}

class saveUserProfileOperation: AsyncOperation  {
    let userProfile: UserProfileModel
    private(set) var result: Result<Bool, Error>?
    
    init (userProfile: UserProfileModel) {
        self.userProfile = userProfile
        super.init()
    }
    
    override func main() {
        if isCancelled {
            state = .finished
            return
        }
        SaveUserProfile.saveUserProfileSettings(userData: userProfile) { [weak self] result in
            self?.result = result
            self?.state = .finished
        }
    }
}
