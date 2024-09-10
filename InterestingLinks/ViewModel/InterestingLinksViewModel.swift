//
//  InterestingLinksViewModel.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 11.02.2024.
//

import Foundation

enum Event {
    case next
}

class InterestingLinksViewModel: ObservableObject {
    
    var onEvent: ((Event) -> Void)?
    
    @Published var links: [Links] = []
    
    private let userDefaultsKey = "LinksKey1"
    let userDefaults = UserDefaults.standard
    
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
    
}
