//
//  IntroductionViewModel.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 08.02.2024.
//

import Foundation

class IntroductionViewModel: ObservableObject {
    enum Event {
        case next
    }
    
    var onEvent: ((Event) -> Void)?
    
}
