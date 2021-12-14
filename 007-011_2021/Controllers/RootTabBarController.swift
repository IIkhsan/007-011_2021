//
//  RootTabBarController.swift
//  007-011_2021
//
//  Created by Evans Owamoyo on 14.12.2021.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var networkController: NetworkDictionaryViewController?
        var persistController: PersistableViewController?
        
        if let controllers = viewControllers {
            for controller in controllers {
                guard let navRootController = (controller as! UINavigationController).viewControllers.first else {
                    return 
                }
                if navRootController is NetworkDictionaryViewController {
                    networkController = navRootController as? NetworkDictionaryViewController
                } else if navRootController is PersistableViewController {
                    persistController = navRootController as? PersistableViewController
                }
            }
        }
        
        if networkController != nil && persistController != nil {
            networkController!.networkDelegate = persistController
        }
    }

}
