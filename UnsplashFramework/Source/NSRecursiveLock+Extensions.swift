//
//  NSRecursiveLock+Extensions.swift
//  UnsplashFramework
//
//  Created by Pablo on 01/12/2017.
//  Copyright © 2017 Pablo Camiletti. All rights reserved.
//


import Foundation


extension NSRecursiveLock
{
    /// Closure that will be executed thread-safely.
    func runCriticalScope<T>(closure: () -> T) -> T
    {
        lock()
        let value = closure()
        unlock()
        return value
    }
}
