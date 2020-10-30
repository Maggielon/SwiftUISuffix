//
//  Color.swift
//  ShareExtension
//
//  Created by Анастасия on 30.10.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import SwiftUI

extension Color {
    
    init(r: Double) {
        self = Color(red: r, green: (1.0 - r), blue: 0.0)
    }
}
