//
//  SuffixService.swift
//  ShareExtension
//
//  Created by Анастасия on 19.10.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Foundation

final class SuffixService: ObservableObject {
    
    static var shared = SuffixService()
    
    @Published var suffixes: [Suffix] = []
    @Published var top3Suffixes: [Suffix] = []
    @Published var top5Suffixes: [Suffix] = []
    
    private var allSuffixes: [Suffix] = []
    
    private init() { }
    
    func suffixes(for text: String, type: SortType) {
        guard !text.isEmpty else { return }
        var suffixes: [Suffix] = []
        let array = text.components(separatedBy: CharacterSet(charactersIn: " \n\t"))
        let sequences = array.compactMap {
            SuffixSequence(string: $0.lowercased())
        }
        for seq in sequences {
            for i in seq {
                if suffixes.contains(where: { $0.string == i }) {
                    suffixes.first { $0.string == i }?.updateValue()
                } else {
                    suffixes.append(Suffix(string: i, count: 1))
                }
            }
        }
        self.allSuffixes = suffixes
        self.suffixes = suffixes
        self.top3Suffixes = self.getTop(by: 3)
        self.top5Suffixes = self.getTop(by: 5)
        self.sort(type)
    }
    
    func sort(_ type: SortType) {
        switch type {
        case .asc:
            self.allSuffixes = self.allSuffixes.sorted { $0.string < $1.string }
            self.suffixes = self.allSuffixes
        case .desc:
            self.allSuffixes = self.allSuffixes.sorted { $0.string > $1.string }
            self.suffixes = self.allSuffixes
        }
    }
    
    func search(text: String) -> [Suffix] {
        guard !text.isEmpty else { return self.allSuffixes }
        return self.allSuffixes.filter { $0.string.contains(text.lowercased()) }
    }
    
    private func getTop(by length: Int, count: Int = 10) -> [Suffix] {
        Array(self.allSuffixes.filter { $0.string.count == length }.sorted { $0.count > $1.count }.prefix(count))
    }
}
