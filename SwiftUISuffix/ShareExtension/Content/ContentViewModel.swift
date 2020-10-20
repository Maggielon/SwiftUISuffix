//
//  ContentViewModel.swift
//  SwiftUISuffix
//
//  Created by Анастасия on 19.10.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Combine
import SwiftUI

final class ContentViewModel: ObservableObject {
    
    @Published var selected: Int = 0
    @Published var selectedSort: Int = SortType.asc.rawValue
    
    @Published var searchText: String = ""
    
    private var sortType: SortType {
        SortType(rawValue: self.selectedSort) ?? .asc
    }
    
    @Published var text: String = ""
    @Published private(set) var allSuffix: [Suffix] = []
    @Published private(set) var top3Suffix: [Suffix] = []
    @Published private(set) var top5Suffix: [Suffix] = []
    
    private var service = SuffixService.shared
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $text
            .sink { value in
                self.service.suffixes(for: value, type: self.sortType)
                self.allSuffix = self.service.search(text: "", sort: self.sortType)
            }
            .store(in: &subscriptions)
        $selectedSort
            .sink { value in
                self.allSuffix = self.service.search(text: "", sort: SortType(rawValue: value) ?? .asc)
            }
            .store(in: &subscriptions)
        service.$suffixes
            .sink { value in
                self.allSuffix = value
            }.store(in: &subscriptions)
        service.$top3Suffixes
            .sink { value in
                self.top3Suffix = value
            }.store(in: &subscriptions)
        service.$top5Suffixes
            .sink { value in
                self.top5Suffix = value
            }.store(in: &subscriptions)
        $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { searchText in
                self.allSuffix = self.service.search(text: searchText, sort: self.sortType)
            }.store(in: &subscriptions)
    }
}
