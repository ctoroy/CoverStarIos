//
//  AppDelegate.swift
//  CoverStar
//
//  Created by taehan park on 2022/03/24.
//

import Firebase
import FirebaseMessaging
import UserNotifications
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        FirebaseApp.configure()
            UNUserNotificationCenter.current().delegate = self
            Messaging.messaging().delegate = self

            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter
              .current()
              .requestAuthorization(
                options: authOptions,completionHandler: { (_, _) in }
              )
            application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        Static.pushId = Messaging.messaging().fcmToken ?? ""
//        appData.set("", forKey: "userID")
        Thread.sleep(forTimeInterval: 1.0);
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            Static.appVer = version
        }
    
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        _ = SceneDelegate()

//        if let windowScene = scene as? UIWindowScene {
//            let window = UIWindow(windowScene: windowScene)
//            window.rootViewController = IntroViewController()
//            self.window = window
//            window.makeKeyAndVisible()
//        }

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.

        Static.pushId = fcmToken!
    }
    
    private func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication,
                       didReceiveRemoteNotification notification: [AnyHashable : Any],
                       fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

      }
    
//    func application(
//          _ app: UIApplication,
//          open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
//        ) -> Bool {
//          var handled: Bool
//
//          handled = GIDSignIn.sharedInstance.handle(url)
//          if handled {
//              // Handle other custom URL types.
//            return true
//          }
//
//
//          // If not handled by this app, return false.
//          return false
//        }
}

