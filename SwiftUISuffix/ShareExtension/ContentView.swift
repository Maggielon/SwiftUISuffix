//
//  ContentView.swift
//  SwiftUISuffix
//
//  Created by Анастасия on 19.10.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import SwiftUI
import MobileCoreServices

struct ContentView: View {
    
    @ObservedObject var  viewModel = ContentViewModel()
    @Binding var text: String
    
    var body: some View {
        VStack {
            Picker(selection: self.$viewModel.selected, label: Text("Select")) {
                Text("All").tag(0)
                Text("3x").tag(1)
                Text("5x").tag(2)
            }.pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 15)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(text: .constant(""))
    }
}
