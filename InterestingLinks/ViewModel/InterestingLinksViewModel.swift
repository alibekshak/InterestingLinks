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
}

class InterestingLinksViewModel: ObservableObject {
    
    var onEvent: ((Event) -> Void)?
    
    @Published var links: [Links] = []
    @Published var titleLink: String = ""
    @Published var link: String = ""
    
    private let userDefaultsKey = "LinksKey1"
    let userDefaults = UserDefaults.standard
    
    init() {
        loadLinksFromUserDefault()
    }
    
    
    private func saveLinksToUserDefault() {
        guard let encodedData = try? JSONEncoder().encode(links) else {
            return
        }
        
        userDefaults.set(encodedData, forKey: userDefaultsKey)
    }
    
    @discardableResult
    func loadLinksFromUserDefault() -> Bool {
        guard let savedData = userDefaults.data(forKey: userDefaultsKey),
              let decodedLinks = try? JSONDecoder().decode([Links].self, from: savedData) else {
            return false
        }
        
        DispatchQueue.main.async {
            self.links = decodedLinks
        }
        return true
    }
    
    func save() {
        guard !titleLink.isEmpty, !link.isEmpty else {
            return
        }
        
        let newLink = Links(name: titleLink, link: link)
        
            DispatchQueue.main.async {
                self.links.append(newLink)
                self.saveLinksToUserDefault()
                self.onEvent?(.save)
            }
    }
    
    func removeLink(at offsets: IndexSet) {
        links.remove(atOffsets: offsets)
        saveLinksToUserDefault()
    }
    
    func moveLink(from source: IndexSet, to destination: Int) {
        links.move(fromOffsets: source, toOffset: destination)
        saveLinksToUserDefault()
    }
}
