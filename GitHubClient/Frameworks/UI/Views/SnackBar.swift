//
//  SnackBar.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/24.
//

import Foundation
import SwiftUI

struct SnackBar: View {
    
    @Binding var text: String
    @Binding var shouldShow: Bool
    
    private let animationDuration: Double = 0.2
    
    @State private var opacity: Double = 0
    @State private var hideAfter: Double = 2
    
    var body: some View {
        VStack {
            Spacer()
            Text(text)
                .padding([.bottom, .top], 8)
                .padding([.leading, .trailing], 16)
                .foregroundColor(.secondaryLabel)
                .background(Color.systemFill)
                .cornerRadius(8)
                .opacity(opacity)
                .animation(.easeOut.delay(animationDuration))
            Spacer().frame(height: 24)
        }
        .onChange(of: shouldShow, perform: { value in
            let opacity: Double = value ? 1 : 0
            withAnimation {
                self.opacity = opacity
            }
        })
    }
}
