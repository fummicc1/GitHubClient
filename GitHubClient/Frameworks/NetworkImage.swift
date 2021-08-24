//
//  NetworkImage.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/23.
//

import Foundation
import SwiftUI
import Kingfisher

struct NetworkImage: View {
    
    let url: String
    let size: CGSize
    
    var body: some View {
        let processor = DownsamplingImageProcessor(size: size)
        return KFImage(URL(string: url))
            .setProcessor(processor)
    }
}
