//
//  SuffixIterator.swift
//  SwiftUISuffix
//
//  Created by Анастасия on 19.10.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Foundation

struct SuffixIterator: IteratorProtocol {
    
    let string: String
    var last: String.Index
    var offset: String.Index
    
    init(string: String) {
        self.string = string
        self.last = string.endIndex
        self.offset = string.startIndex
    }
    
    mutating func next() -> String? {
        guard offset < last else { return nil }
        
        let sub: Substring = string[offset..<last]
        string.formIndex(after: &offset)
        return String(sub)
    }
}
