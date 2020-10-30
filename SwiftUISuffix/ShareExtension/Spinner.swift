//
//  Spinner.swift
//  ShareExtension
//
//  Created by Анастасия on 30.10.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import SwiftUI
import UIKit

public struct Spinner: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
    
    public init(style: UIActivityIndicatorView.Style) {
        self.style = style
    }

    public func makeUIView(context: Context) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }
    
    public func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner(style: .large)
    }
}


