//
//  AddLinksViewModel.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 08.02.2024.
//

import Foundation

class AddLinksViewModel: ObservableObject {
    enum Event {
        case openSheet
    }
    
    var onEvent: ((Event) -> Void)?
    
}
