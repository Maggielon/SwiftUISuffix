//
//  SuffixSequence.swift
//  SwiftUISuffix
//
//  Created by Анастасия on 19.10.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Foundation

struct SuffixSequence: Sequence {
    
    let string: String
    
    func makeIterator() -> SuffixIterator {
        SuffixIterator(string: string)
    }
}
