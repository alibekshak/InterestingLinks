//
//  InterestingLinksViewModel.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 11.02.2024.
//

import Foundation

class InterestingLinksViewModel: ObservableObject {
    enum Event {
        case next
        case save
        case openSheet
    }
    
    var onEvent: ((Event) -> Void)?
    
    var links: [Links] = []
    
    @Published var titleLink: String = ""
    @Published var link: String = ""
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("links.data")
    }
    
    func load() async throws {
        let task = Task<[Links], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                onEvent?(.next)
                return []
            }
                let dailyScrums = try JSONDecoder().decode([Links].self, from: data)
                onEvent?(.next)
                return dailyScrums
        }
        let links = try await task.value
        self.links = links
    }
    
    func save() async throws {
        guard !titleLink.isEmpty, !link.isEmpty else {

            return
        }
        
        let newLink = Links(name: titleLink, link: link)
        links.append(newLink)
        
        let task = Task {
            let data = try JSONEncoder().encode(links)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
            onEvent?(.save)
        }
        _ = try await task.value
    }
    
    func removeLink(at index: Int) {
        links.remove(at: index)
    }
}
