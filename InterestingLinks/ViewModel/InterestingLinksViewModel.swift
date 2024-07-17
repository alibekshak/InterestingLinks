//
//  InterestingLinksViewModel.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 11.02.2024.
//

import Foundation

enum Event {
    case next
    case save
    case openSheet
}

class InterestingLinksViewModel: ObservableObject {
    
    var onEvent: ((Event) -> Void)?
    
    @Published var links: [Links] = []
    @Published var titleLink: String = ""
    @Published var link: String = ""
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
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
        DispatchQueue.main.async {
            self.links = links
        }
    }
    
    func save() async throws {
        guard !titleLink.isEmpty, !link.isEmpty else {
            return
        }
        
        let newLink = Links(name: titleLink, link: link)
        
        await Task {
            DispatchQueue.main.async {
                self.links.append(newLink)
            }
        }
        
        try? await Task {
            try await saveLinks()
            DispatchQueue.main.async {
                self.onEvent?(.save)
            }
        }
    }
    
    private func saveLinks() async throws {
        let task = Task {
            let data = try JSONEncoder().encode(self.links)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
    func removeLink(at offsets: IndexSet) {
        links.remove(atOffsets: offsets)
        Task {
            try? await saveLinks()
        }
    }
    
    func moveLink(from source: IndexSet, to destination: Int) {
        links.move(fromOffsets: source, toOffset: destination)
        Task {
            try? await saveLinks()
        }
    }
}
