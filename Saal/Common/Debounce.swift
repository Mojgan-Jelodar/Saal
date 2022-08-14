//
//  Debounce.swift
//  Saal
//
//  Created by Mozhgan on 8/14/22.
//

import Foundation
import Combine
struct Debounce<S: Scheduler> {
    let scheduler: S
    let dueTime: S.SchedulerTimeType.Stride
}
extension Debounce where S == RunLoop {
    
    static var `default`: Debounce<S> {
        Debounce(scheduler: RunLoop.main, dueTime: .microseconds(500))
    }
}

extension Debounce where S == ImmediateScheduler {
    static var test: Debounce<S> {
        Debounce(scheduler: ImmediateScheduler.shared, dueTime: .microseconds(500))
    }
}
