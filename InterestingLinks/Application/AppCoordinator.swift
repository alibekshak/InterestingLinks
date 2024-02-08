//
//  AppCoordinator.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 08.02.2024.
//

import Foundation
import UIKit
import SwiftUI

class AppCoordinator {
    var rootController: UIViewController!
    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
    
//    func start() {
//        self.rootController = intoductionScreen()
//        window.rootViewController = rootController
//    }
    
//    private func intoductionScreen() -> UIViewController {
//        let viewModel = IntroductionViewModel()
//        let controller = UIHostingController(rootView: IntroductionView(viewModel: viewModel))
//        
//        viewModel.onEvent = {[weak controller, weak self] destination in
//            guard let self else { return }
//            switch destination {
//            case .next
//            }
//        }
//    }
    
}
