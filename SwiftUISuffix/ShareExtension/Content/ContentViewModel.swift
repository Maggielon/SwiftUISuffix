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
    
    @Published private(set) var history: [Item] = []
    @Published private(set) var isLoading: Bool = false
    
    private var service = SuffixService.shared
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $text
            .sink { value in
                self.service.suffixes(for: value, type: self.sortType)
                self.allSuffix = self.service.search(text: "", sort: self.sortType)
                let history = UserDefaultsManager.shared[.history] as? [String] ?? [String]()
                self.history = history.compactMap { Item(text: $0) }
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
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { searchText in
                self.allSuffix = self.service.search(text: searchText, sort: self.sortType)
            }.store(in: &subscriptions)
    }
    
    func test() {
        self.isLoading = true
        let scheduler = JobScheduler()
        scheduler.jobs = self.history.compactMap { item in
            item.isLoading = true
            let queue = JobQueue(jobs: [{
                _ = self.service.simpleSuffix(for: item.text)
            }])
            let job = Job(queue: queue) { time in
                item.time = time
                item.isLoading = false
            }
            return job
        }
        scheduler.execute()
    }
}

extension Item: Identifiable {
    public var id: String {
        UUID().uuidString
    }
}

class Item {
    var text: String
    var time: TimeInterval? = nil
    var isLoading: Bool = false 
    
    init(text: String) {
        self.text = text
    }
}
