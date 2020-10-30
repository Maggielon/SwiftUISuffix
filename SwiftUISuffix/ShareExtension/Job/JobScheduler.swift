//
//  JobScheduler.swift
//  SwiftUISuffix
//
//  Created by Анастасия on 28.10.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Foundation

class JobScheduler {
    
    var jobs: [Job] = []
    var completion: (() -> Void)?

    func execute() {
        jobs.forEach {
            let job = $0
            job.queue.enter()
            job.queue.execute { time in
                job.isComplete = true
                job.completion?(time)
                self.complete()
            }
        }
    }
    
    private func complete() {
        guard !self.jobs.contains(where: { !$0.isComplete }) else { return }
        self.completion?()
    }
}
