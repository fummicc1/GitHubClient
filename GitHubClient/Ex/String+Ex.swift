//
//  String+Ex.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import Foundation

extension String {
    func convert(dateFormatter: DateFormatter) -> Date {
        dateFormatter.date(from: self)!
    }
    
    func convert(formatter: ISO8601DateFormatter) -> Date {
        return formatter.date(from: self)!
    }
}
