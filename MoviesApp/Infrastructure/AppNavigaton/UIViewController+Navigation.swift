//
//  UIViewController+Navigation.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

extension UIViewController: NavigationProtocol {
    func navigate(to router: RouteProtocol) {
        navigate(to: router.destination, with: router.style)
    }

    private func navigate(to viewController: UIViewController, with style: RouteStyle) {
        switch style {
        case .push:
            navigationController?.pushViewController(viewController, animated: true)
        case .present:
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }
    }
}
