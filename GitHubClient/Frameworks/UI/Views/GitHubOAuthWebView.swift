//
//  GitHubOAuthWebView.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/26.
//

import Foundation
import SwiftUI
import SafariServices

struct GitHubOAuthWebView: UIViewControllerRepresentable {
    
    @Binding var code: String?
    private let url: URL = AuthClientConst.url
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let vc = SFSafariViewController(url: url)
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {        
    }
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(code: self.$code)
        return coordinator
    }
    
    class Coordinator: NSObject {
        @Binding var code: String?
        
        init(code: Binding<String?>) {
            self._code = code
            super.init()
        }
    }
    
}

extension GitHubOAuthWebView.Coordinator: SFSafariViewControllerDelegate {
    
    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        let callbackURL = AuthClientConst.callbackURL
        
        let url = URL
        
        if url.host == callbackURL.host && url.path == callbackURL.path {
            
            let components = URLComponents(string: url.absoluteString)
            
            if let code = components?.queryItems?.last(where: { $0.name == "code" })?.value {
                self.code = code
            }
        }
    }
}
