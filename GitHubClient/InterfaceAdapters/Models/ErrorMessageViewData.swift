//
//  ErrorMessageViewData.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation

struct ErrorMessageViewData: Hashable, Identifiable {
    
    let message: String
    var id: String
    
    internal init(error: Error, message: String) {
        self.id = error.localizedDescription
        self.message = message
    }
}
