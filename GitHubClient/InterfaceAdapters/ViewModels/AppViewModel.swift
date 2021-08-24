//
//  AppViewModel.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/24.
//

import Foundation
import Combine

class AppViewModel: ObservableObject {
    @Published var me: MeViewData?
    @Published var isLoggedIn: Bool = false
    

    
    init() {
        
    }
}
