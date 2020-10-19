//
//  SortType.swift
//  ShareExtension
//
//  Created by Анастасия on 19.10.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Foundation

enum SortType: Int {
    case asc = 0, desc
    
    var title: String {
        switch self {
        case .asc: return "ASC"
        case .desc: return "DESC"
        }
    }
    
    static var all: [SortType] {
        return [.asc, .desc]
    }
}

extension SortType: Identifiable {
    
    var id: String {
        return "\(self.rawValue)"
    }
}
