//
//  AppDelegate.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 24/06/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootController: UINavigationController { return self.window!.rootViewController as! UINavigationController }
    private lazy var applicationCoordinator: Coordinator = self.makeCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = AppNavigationController()
        applicationCoordinator.start()

        return true
    }
    
    private func makeCoordinator() -> Coordinator {
        let services: ApiServicesType = CommandLine.arguments.contains("--uitesting") ? MockApiServices() : ApiServices()
        return AppCoordinator(router: Router(rootController: rootController), services: services)
    }
}

