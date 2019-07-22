//
//  AppDelegate.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 4.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let photosViewController = PhotosViewController()
        let navigationViewController = UINavigationController(rootViewController: photosViewController)
        navigationViewController.navigationBar.prefersLargeTitles = true
        navigationViewController.navigationBar.barStyle = .black
        window?.rootViewController = navigationViewController

        return true
    }

}

