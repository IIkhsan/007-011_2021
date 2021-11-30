//
//  UIViewController+Alert.swift
//  007-011_2021
//
//  Created by Роман Сницарюк on 24.11.2021.
//

import Foundation
import UIKit

extension UIViewController {
  func showAlert(title: String, message: String) {
    let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
    controller.addAction(action)
    self.present(controller, animated: true, completion: nil)
  }
}
