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
            .padding(.horizontal, 15)
            .padding(.top, 20)
            List(self.viewModel.allSuffix) { suffix in
                HStack {
                    Text(suffix.string)
                    Spacer()
                    Text("\(suffix.count)")
                }
                
            }
        }
    }
}
