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
        let viewModel = IntroductionViewModel()
        let controller = UIHostingController(rootView: IntroductionView(viewModel: viewModel))
        
        viewModel.onEvent = {[weak controller, weak self] destination in
            guard let self else { return }
            switch destination {
            case .next:
                controller?.navigationController?.pushViewController(addLinks(), animated: true)
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
    
    private func addLinks() -> UIViewController {
        let viewModel = AddLinksViewModel()
        let writeDownViewModel = WriteDownInfoViewModel()
        let controller = UIHostingController(rootView: AddLinksView(viewModel: viewModel, writeDownViewModel: writeDownViewModel))
        
        viewModel.onEvent = { [weak controller, weak self] event in
            guard let self = self else { return }
            switch event {
            case .openSheet:
                controller?.present(writeDownInfo(writeDownViewModel: writeDownViewModel), animated: true)
            }
        }
        
        Task {
            do {
                try await writeDownViewModel.load()
            } catch {
                print("\(error)")
            }
        }
        
        controller.modalPresentationStyle = .fullScreen
        
        return controller
    }
    
    private func writeDownInfo(writeDownViewModel: WriteDownInfoViewModel) -> UIViewController {
        let controller = UIHostingController(rootView: WriteDownInfoView(viewModel: writeDownViewModel))
        
        writeDownViewModel.onEvent = { [weak controller] event in
            switch event {
            case .save:
                Task {
                    do {
                        try await writeDownViewModel.save()
                    } catch {
                        print("\(error)")
                    }
                }
                controller?.dismiss(animated: true)
            }
        }
        
        controller.modalPresentationStyle = .pageSheet
        
        if let sheet = controller.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        
        return controller
    }
    
}

