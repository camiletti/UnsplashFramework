//
//  URLSessionTaskOperation.swift
//  UnsplashFramework
//
//  Copyright 2017 Pablo Camiletti
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished
//  to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//


import Foundation


/// Representation of the states the operation can be at.
private enum OperationState
{
    /// The operation is ready to start.
    case ready
    
    /// The operation is being executed.
    case executing
    
    /// The operation has finished.
    case finished
    
    /// The operation has been cancelled.
    case cancelled
}


/// An operation that is charge of handling a URLSessionTask.
class URLSessionTaskOperation: Operation
{
    
    // MARK: - Properties
    
    /// The task to be executed.
    let task: URLSessionTask
    
    /// A Boolean value indicating whether the operation executes its task asynchronously.
    override var isAsynchronous : Bool { return true }
    
    /// Current state of the operation. This computed variable should be access when reading
    /// and writing the state value since it's thread safe.
    private var state : OperationState
    {
        get
        {
            return self.state🔐.runCriticalScope
            {
                return self._state
            }
        }
        
        set
        {
            self.state🔐.runCriticalScope
            {
                if self._state != .finished
                {
                    self._state = newValue
                }
            }
        }
    }
    /// Lock to prevent race conditions when reading and writing the state.
    private let state🔐 = NSRecursiveLock()
    
    /// Current state of the operation.
    private var _state : OperationState = .ready
    {
        willSet
        {
            if let keyPath = self.keyPath(forState: self._state) { willChangeValue(forKey: keyPath) }
            if let keyPath = self.keyPath(forState: newValue)    { willChangeValue(forKey: keyPath) }
        }
        
        didSet
        {
            if let keyPath = self.keyPath(forState: oldValue)    { didChangeValue(forKey: keyPath) }
            if let keyPath = self.keyPath(forState: self._state) { didChangeValue(forKey: keyPath) }
        }
    }
    
    /// A Boolean value indicating whether the operation is currently executing.
    override var isExecuting : Bool { return self.state == .executing }
    
    /// A Boolean value indicating whether the operation has finished executing its task.
    override var isFinished  : Bool { return self.state == .finished  }
    
    // isReady: For this case we don't need to override it as we are not doing any internal preparation.
    override var isCancelled : Bool { return self.state == .cancelled }
    
    /// Observation for the state changes of the task.
    private var taskStateObservation : NSKeyValueObservation?
    
    
    // MARK: - Initializers
    
    /// Creates an operation that will run the specified task.
    init(with task: URLSessionTask)
    {
        self.task = task
        super.init()
    }
    
    
    // MARK: - Life cycle
    
    /// Begins the execution of the operation.
    override func start()
    {
        guard self.isCancelled == false else
        {
            return
        }
        
        assert(self.task.state == .suspended, "🚫 URLSessionTaskOperation: The task was externally resumed")
        
        self.state = .executing
        
        self.taskStateObservation = task.observe(\.state)
        { (task, change) in
            
            if task.state == .completed
            {
                self.finish()
            }
        }
        
        task.resume()
    }
    
    
    /// Called at the end of the operation's execution.
    func finish()
    {
        self.state = .finished
    }
    
    
    /// Advises the operation object that it should stop executing its task.
    override func cancel()
    {
        self.taskStateObservation?.invalidate()
        self.task.cancel()
        self.state = .cancelled
    }
    
    
    // MARK: - Helpers
    
    /// Returns the keyPath that corresponds to the state if it has been overriden.
    private func keyPath(forState state: OperationState) -> String?
    {
        // Not using Swift 4's KeyPath notation as currently
        // has issues. Update in the future when is working fine.
        // Link: https://forums.developer.apple.com/thread/79683
        
        switch state
        {
        case .ready:
            return nil // We are not overriding isReady
            
        case .executing:
            return #keyPath(isExecuting)
            
        case .finished:
            return #keyPath(isFinished)
            
        case .cancelled:
            return #keyPath(isCancelled)
        }
    }
}
