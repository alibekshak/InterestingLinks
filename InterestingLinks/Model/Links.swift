//
//  Links.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 09.02.2024.
//

import Foundation

struct Links: Identifiable, Codable {
    let id: UUID
    let name: String
    let link: String
}

extension Links {
    init(name: String, link: String) {
        self.id = UUID()
        self.name = name
        self.link = link
    }
}

extension Links {
    
    static let sampleData: [Links] = [
    Links(name: "Google", link: "https://www.google.kz/?hl=ru"),
    Links(name: "YouTube", link: "https://www.youtube.com/"),
    Links(name: "Gmail", link: "https://mail.google.com/")
    ]
}
