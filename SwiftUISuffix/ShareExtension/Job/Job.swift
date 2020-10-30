//
//  Job.swift
//  ShareExtension
//
//  Created by Анастасия on 30.10.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Foundation

class Job {
    var queue: JobQueue
    var isComplete: Bool = false
    var completion: ((TimeInterval) -> Void)?
    
    init(queue: JobQueue, completion: ((TimeInterval) -> Void)?) {
        self.queue = queue
        self.completion = completion
    }
}
