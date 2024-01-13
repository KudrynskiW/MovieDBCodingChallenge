//
//  AppCoordinator.swift
//  MovieDBCodingChallenge
//
//  Created by Wojciech Kudrynski on 13/01/2024.
//

import Foundation
import UIKit

protocol AppCoordinatorProtocol {
    func start() -> UINavigationController 
    func coordinate(to screen: AppCoordinator.ScreenType)
}

class AppCoordinator: AppCoordinatorProtocol {
    enum Constants {
        static let mainScreenView = "MainScreenView"
        static let detailsScreenView = "DetailsScreenView"
    }
    enum ScreenType {
        case mainScreen
        case detailsScreen(movie: Movie)
    }
    
    let navigationController = UINavigationController()
    let networkManager = NetworkManager()
    
    func start() -> UINavigationController {
        if let viewController = Bundle.main.loadNibNamed(Constants.mainScreenView, owner: nil, options: nil)?.first as? MainScreenViewController {
            viewController.viewModel = MainScreenViewModel(coordinator: self,
                                                           networkManager: networkManager)
            navigationController.pushViewController(viewController, animated: true)
        }
        return navigationController
    }
    
    func coordinate(to screen: ScreenType) {
        switch screen {
        case .mainScreen:
            navigationController.popToRootViewController(animated: true)
        case .detailsScreen(let movie):
            let viewController = Bundle.main.loadNibNamed(Constants.detailsScreenView, owner: nil, options: nil)?.first as? DetailsScreenViewController
            
                viewController?.viewModel = DetailsScreenViewModel(coordinator: self,
                                                                  networkManager: networkManager,
                                                                  movie: movie)
                
            navigationController.pushViewController(viewController ?? UIViewController(), animated: true)
            
            
        }
    }
    
    
}
