//
//  ProfileViewModel.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/24.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var userName: String = ""
    @Published var userID: String = ""    
    
}
