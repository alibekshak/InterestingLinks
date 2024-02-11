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
    
    func start() {
        self.rootController = intoductionScreen()
        window.rootViewController = rootController
    }
    
    private func intoductionScreen() -> UIViewController {
        let viewModel = InterestingLinksViewModel()
        let controller = UIHostingController(rootView: IntroductionView(viewModel: viewModel))
        
        viewModel.onEvent = {[weak controller, weak self] destination in
            guard let self else { return }
            switch destination {
            case .next:
                DispatchQueue.main.async {
                    controller?.navigationController?.pushViewController(self.addLinks(viewModel: viewModel), animated: true)
                }
            case .save:
                DispatchQueue.main.async {
                    controller?.dismiss(animated: true)
                }
            case .openSheet:
                controller?.navigationController?.present(writeDownInofView(viewModel: viewModel), animated: true)
            }
        }
        
        let nc = UINavigationController(rootViewController: controller)
        nc.navigationBar.isTranslucent = false
        nc.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nc.navigationBar.tintColor = UIColor.white
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.backgroundColor = .black
        
        //Configure additional customizations here
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        return nc
    }
    
    private func addLinks(viewModel: InterestingLinksViewModel) -> UIViewController {
        let controller = UIHostingController(rootView: AddLinksView(viewModel: viewModel))
        
        controller.modalPresentationStyle = .fullScreen
        
        return controller
    }
    
    private func writeDownInofView(viewModel: InterestingLinksViewModel) -> UIViewController {
        let controller = UIHostingController(rootView: WriteDownInfoView(viewModel: viewModel))
        
        controller.modalPresentationStyle = .pageSheet
        
        if let sheet = controller.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        
        return controller
    }
}

