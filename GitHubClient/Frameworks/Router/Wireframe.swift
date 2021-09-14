//
//  ViewNavigatable.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/09/14.
//

import Foundation
import SwiftUI

protocol Wireframe {
    
    associatedtype Destination
    associatedtype View: SwiftUI.View
    
    func generateView(with destination: Destination) -> View
}
