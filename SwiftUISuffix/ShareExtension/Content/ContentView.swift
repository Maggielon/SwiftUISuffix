//
//  ContentView.swift
//  SwiftUISuffix
//
//  Created by Анастасия on 19.10.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import SwiftUI
import MobileCoreServices
import Combine

struct ContentView: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            Picker(selection: self.$viewModel.selected, label: Text("Select")) {
                Text("All").tag(0)
                Text("3x").tag(1)
                Text("5x").tag(2)
            }.pickerStyle(SegmentedPickerStyle())
            if self.viewModel.selected == 0 {
                VStack {
                    HStack {
                        Spacer()
                        Picker(selection: self.$viewModel.selectedSort, label: Text("Select")) {
                            ForEach(SortType.all) {
                                Text($0.title).tag($0.rawValue)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                            .frame(width: 100)
                    }
                    TextField("Type your search",text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    List(self.viewModel.allSuffix) { suffix in
                        HStack {
                            Text(suffix.string)
                            Spacer()
                            Text("\(suffix.count)")
                        }
                    }.id(UUID())
                }
            } else if self.viewModel.selected == 1 {
                List(self.viewModel.top3Suffix) { suffix in
                    HStack {
                        Text(suffix.string)
                        Spacer()
                        Text("\(suffix.count)")
                    }
                }
            } else {
                List(self.viewModel.top5Suffix) { suffix in
                    HStack {
                        Text(suffix.string)
                        Spacer()
                        Text("\(suffix.count)")
                    }
                }
            }
        }.padding(.top, 20)
        .padding(.horizontal, 15)
    }
}
