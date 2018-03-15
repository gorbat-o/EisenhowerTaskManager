//
//  PerformanceProtocol.swift
//  EisenhowerTaskManager
//
//  Created by Oleg GORBATCHEV on 15/03/2018.
//  Copyright © 2018 Oleg Gorbatchev. All rights reserved.
//

import Foundation
import FirebasePerformance

extension Performance {
    static var trace: Trace?

    class func start(withKey key: String?) {
        Performance.trace = Performance.startTrace(name: "Perfomance start with \(key ?? "")")
    }

    class func stop() {
        Performance.trace?.stop()
        Performance.trace = nil
    }
}
