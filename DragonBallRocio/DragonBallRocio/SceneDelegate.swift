//
//  SceneDelegate.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 17/3/24.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appState : LoginViewModel = LoginViewModel(loginUseCase: LoginUseCase()) //Aqui el view model global
    var cancelable : AnyCancellable?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        //evaluar si se puede hacer auto-login
        appState.validateControlLogin()
        
        //creamo un navigatop controller
        var nav: UINavigationController?
        
        //la caja de estados o viewRouter
        self.cancelable = appState.$statusLogin
            .sink(receiveValue: { estado in
                switch estado {
                case .notValidate, .none:
                    //ver el login
                    DispatchQueue.main.async {
                        print("vamos pal login")
                        nav = UINavigationController(rootViewController: LogingViewController(appState: self.appState))
                        self.window!.rootViewController = nav
                        self.window!.makeKeyAndVisible()
                    }
                case .success:
                    ""
                case .error:
                    ""
                }
            }
            )
    }
                  
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

