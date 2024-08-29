//
//  AddLinksViewModel.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 29.08.2024.
//

import Foundation

enum EventAddLinks {
    case openSheet
    case save
}

class AddLinksViewModel: ObservableObject {
    var onEvent: ((EventAddLinks) -> Void)?
    
    @Published var links: [Links] = []
    @Published var titleLink: String = ""
    @Published var link: String = ""
    
    private let userDefaultsKey = "LinksKey1"
    let userDefaults = UserDefaults.standard

    
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
    
    private func saveLinksToUserDefault() {
        guard let encodedData = try? JSONEncoder().encode(links) else {
            return
        }
        
        userDefaults.set(encodedData, forKey: userDefaultsKey)
    }
    
    func loadLinksFromUserDefault() {
        guard let savedData = userDefaults.data(forKey: userDefaultsKey),
              let decodedLinks = try? JSONDecoder().decode([Links].self, from: savedData) else {
            return
        }
        
        DispatchQueue.main.async {
            self.links = decodedLinks
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
