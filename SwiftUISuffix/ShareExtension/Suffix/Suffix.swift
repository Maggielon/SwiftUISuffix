//
//  Suffix.swift
//  ShareExtension
//
//  Created by Анастасия on 19.10.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Foundation

class Suffix {
    
    var string: String
    
    var count: Int
    
    init(string: String, count: Int) {
        self.string = string
        self.count = count
    }
    
    func updateValue() {
        count += 1
    }
}

extension Suffix: CustomStringConvertible {
    
    var description: String {
        "\(string) - \(count)"
    }
}

extension Suffix: Identifiable {}
