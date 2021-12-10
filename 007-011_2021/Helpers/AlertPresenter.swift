//
//  AlertPresenter.swift
//  007-011_2021
//
//  Created by Danil Gerasimov on 09.12.2021.
//

import UIKit

class AlertPresenter {
    
    /// Show alert when error occured
    /// - Parameters:
    ///   - title: title of the error
    ///   - message: message of the error
    ///   - viewController: view controller that shows alert
    class func showAlert(title: String? = nil, message: String, on viewController: UIViewController?) {
        weak var vc = viewController
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title ?? "Ошибка",
                                                    message: message,
                                                    preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Закрыть", style: .default))
            vc?.present(alertController, animated: true)
        }
    }
}
