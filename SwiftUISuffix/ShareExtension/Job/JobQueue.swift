//
//  JobQueue.swift
//  SwiftUISuffix
//
//  Created by Анастасия on 28.10.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Foundation

struct JobQueue {
    
    private let jobs: [() -> Void]
    private let queue = DispatchQueue.global(qos: .background)
    private let group = DispatchGroup()
    private var completion: ((TimeInterval) -> Void)?
    private var start = Date()
    
    init(jobs: [() -> Void]) {
        self.jobs = jobs
    }
    
    func enter() {
        for _ in jobs {
            group.enter()
        }
    }
    
    func notify() {
        group.notify(queue: .main) {
            let time = Date().timeIntervalSince(self.start)
            self.completion?(time)
        }
    }
    
    mutating func execute(completion: @escaping (TimeInterval) -> Void) {
        start = Date()
        self.completion = completion
        for job in jobs {
            queue.async { [self] in
                job()
                self.group.leave()
            }
        }
        self.notify()
    }
}
