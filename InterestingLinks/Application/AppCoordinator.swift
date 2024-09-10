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
    let setupGroup = DispatchGroup()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        self.rootController = launchScreen()
        window.rootViewController = rootController
        window.makeKeyAndVisible()
        
        setupGroup.enter()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            self.setupGroup.leave()
        }
        
        setupGroup.notify(queue: .main) {
            let viewModel = InterestingLinksViewModel()
            let viewModelAddLinks = AddLinksViewModel()
            let hasLinks = viewModel.loadLinksFromUserDefault()
            
            if hasLinks {
                self.rootController = self.addLinks(viewModel: viewModelAddLinks)
            } else {
                self.rootController = self.introductionScreen(viewModel: viewModel, viewModelAddLinks: viewModelAddLinks)
            }
            
            self.window.rootViewController = self.rootController
            UIView.transition(with: self.window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        }
    }
    
    private func launchScreen() -> UIViewController {
        let viewController = UIHostingController(rootView: LaunchScreen())
        
        return viewController
    }
    
    private func introductionScreen(viewModel: InterestingLinksViewModel, viewModelAddLinks: AddLinksViewModel) -> UIViewController {
        let controller = UIHostingController(rootView: IntroductionView(viewModel: viewModel))
        
        viewModel.onEvent = {[weak controller, weak self] destination in
            guard let self = self, let controller = controller else { return }
            switch destination {
            case .next:
                DispatchQueue.main.async {
                    controller.navigationController?.pushViewController(self.addLinks(viewModel: viewModelAddLinks), animated: true)
                }
            case .save:
                DispatchQueue.main.async {
                    controller.dismiss(animated: true)
                }
            }
        }
        
        let nc = UINavigationController(rootViewController: controller)
        configureNavigationBar(nc)
        return nc
    }
    
    private func addLinks(viewModel: AddLinksViewModel) -> UIViewController {
        let controller = UIHostingController(rootView: AddLinksView(viewModel: viewModel))
        viewModel.onEvent = {[weak controller, weak self] destination in
            guard let self = self, let controller = controller else { return }
            print("Событие вызвано: \(destination)")
            switch destination {
            case .openSheet:
                DispatchQueue.main.async {
                    let infoController = self.writeDownInfoView(viewModel: viewModel)
                    controller.present(infoController, animated: true)
                }
            case .save:
                DispatchQueue.main.async {
                    controller.dismiss(animated: true)
                }
            }
        }
        
        return controller
    }
    
    private func writeDownInfoView(viewModel: AddLinksViewModel) -> UIViewController {
        let controller = UIHostingController(rootView: WriteDownInfoView(viewModel: viewModel))
        controller.modalPresentationStyle = .pageSheet
        
        if let sheet = controller.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        
        return controller
    }
    
    private func configureNavigationBar(_ nc: UINavigationController) {
        nc.navigationBar.isTranslucent = false
        nc.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nc.navigationBar.tintColor = UIColor.white
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.backgroundColor = .black
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
}

