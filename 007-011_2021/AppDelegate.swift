//
//  AppDelegate.swift
//  007-011_2021
//
//  Created by ilyas.ikhsanov on 20.11.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  private let interactor: Interactor = InteractorImpl()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    if interactor.didUserSawOnboarding() {
      window?.rootViewController = UINavigationController(rootViewController: SavedWordsViewController())
    } else {
      interactor.setStatusOfOnboarding(bool: true)
      window?.rootViewController = OnboardingPageViewController()
    }
    window?.makeKeyAndVisible()
    return true
  }
}
