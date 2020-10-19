//
//  ContentViewModel.swift
//  SwiftUISuffix
//
//  Created by Анастасия on 19.10.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Combine

final class ContentViewModel: ObservableObject {
    
    @Published var selected: Int = 0
    
     @Published var text: String = ""
    
    @Published private(set) var allSuffix: [Suffix] = []
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $text.sink(receiveValue: { value in
            self.convert(for: value)
        }).store(in: &subscriptions)
    }

    func convert(for text: String) {
        guard !text.isEmpty else { return }
        let array = text.components(separatedBy: " ")
        let sequences = array.compactMap {
            SuffixSequence(string: $0.lowercased())
        }
        for seq in sequences {
            for i in seq {
                if allSuffix.contains(where: { $0.string == i }) {
                    allSuffix.first { $0.string == i }?.updateValue()
                } else {
                    allSuffix.append(Suffix(string: i, count: 1))
                }
            }
        }
    }
}
