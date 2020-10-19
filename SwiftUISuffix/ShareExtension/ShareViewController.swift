//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Анастасия on 19.10.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import UIKit
import SwiftUI
import MobileCoreServices

class ShareViewController: UIViewController {
    
    @ObservedObject var shareViewModel = ShareViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        handleSharedFile()
    }
    
    func setup() {
        view.backgroundColor = .white
        
        let contentView = ContentView(text: $shareViewModel.text)
        
        let vc  = UIHostingController(rootView: contentView)
        addChild(vc)
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        vc.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        vc.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        vc.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        vc.view.backgroundColor = .clear
    }
    
    func handleSharedFile() {
        let attachments = (extensionContext?.inputItems.first as? NSExtensionItem)?.attachments ?? []
        let contentType = kUTTypeText as String
        for provider in attachments {
            if provider.hasItemConformingToTypeIdentifier(contentType) {
                provider.loadItem(forTypeIdentifier: contentType, options: nil) { [weak self] text, error in
                    guard let strongify = self else { return }
                    guard error == nil else { return }
                    strongify.shareViewModel.text = (text as? String) ?? ""
                }
            }
        }
    }
}
