//
//  SceneDelegate.swift
//  Networking
//
//  Created by Artur on 07.02.2023.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        self.window = UIWindow(windowScene: windowScene)

        let vc = MainCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout.init())
        window?.backgroundColor = .black
        let rootNC = UINavigationController(rootViewController: vc)

        self.window?.rootViewController = rootNC
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

