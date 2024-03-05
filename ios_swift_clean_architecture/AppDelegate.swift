//
//  AppDelegate.swift
//  ios_swift_clean_architecture
//
//  Created by Lam Nguyen Tuan on 04/03/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setUpRootView()
        configUI()
        return true
    }
    
    private func setUpRootView() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = Storyboard.load(.main, type: UINavigationController.self, isInitial: true)
        let photoNavigator = PhotoNavigator(navigationController: navigationController)
        photoNavigator.showPhoto()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        self.window = window
    }

    private func configUI() {
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        UINavigationBar.appearance().backgroundColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.red
        UINavigationBar.appearance().tintColor = UIColor.red
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register {
            PhotoRepository() as PhotoUseCase
        }
    }
}
