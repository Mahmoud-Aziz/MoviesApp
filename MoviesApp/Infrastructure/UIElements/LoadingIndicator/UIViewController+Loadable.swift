//
//  UIViewController+Loadable.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import SVProgressHUD
import UIKit

extension UIViewController: Loadable {
    func showLoader(_ show: Bool) {
        if show {
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.setForegroundColor(.red)
            SVProgressHUD.setBackgroundColor(.black)
            SVProgressHUD.show()
        } else {
            SVProgressHUD.dismiss()
        }
    }
}
