//
//  ErrorMessageViewData.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation

struct ErrorMessageViewData: Identifiable {
    
    let error: Error
    
    let message: String
    
    var id: String {
        error.localizedDescription
    }
}
