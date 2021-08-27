//
//  GitHubOAuthWebView.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/26.
//

import Foundation
import SwiftUI
import WebKit

struct GitHubOAuthWebView: UIViewRepresentable {
    
    @Binding var code: String?
    
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: AuthClientConst.url))
        view.navigationDelegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {        
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

extension GitHubOAuthWebView.Coordinator: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }
        
        let callbackURL = AuthClientConst.callbackURL
        
        if url.host == callbackURL.host && url.path == callbackURL.path {
            
            let components = URLComponents(string: url.absoluteString)
            
            if let code = components?.queryItems?.last(where: { $0.name == "code" })?.value {
                self.code = code
            }
        }
        decisionHandler(.allow)
    }
}
