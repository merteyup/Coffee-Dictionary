//
//  AppDelegate.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 13.02.2023.
//

import UIKit
import RealmSwift
import GoogleMobileAds
import FirebaseCore
import FirebaseFirestore
import RevenueCat


import OneSignal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        let db = Firestore.firestore()
        
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_dnHuAKRTHYyfXpfHGZquiFtmyBR")

        GADMobileAds.sharedInstance().start(completionHandler: nil)
        NetworkMonitor.shared.startMonitoring { status in
            
        }

        openRealm()
        // Realm file location.
        print("RealmDBLocation: \(Realm.Configuration.defaultConfiguration.fileURL)")
        
        
        
        // Remove this method to stop OneSignal Debugging
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)

         
         // OneSignal initialization
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId("1d599f15-5dc5-4c98-be17-0ebc9efaa9e4")
         
         // promptForPushNotifications will show the native iOS notification permission prompt.
         // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
        OneSignal.promptForPushNotifications(userResponse: { accepted in
           print("User accepted notifications: \(accepted)")
         })
   
        
        
        return true
    }
    
    func openRealm() {
        let bundlePath = Bundle.main.path(forResource: "default", ofType: "realm")!
        let defaultPath = Realm.Configuration.defaultConfiguration.fileURL!.path
        let fileManager = FileManager.default

        if !fileManager.fileExists(atPath: defaultPath){
            print("use pre-populated database")
            do {
                try fileManager.copyItem(atPath: bundlePath, toPath: defaultPath)
                print("Copied")
            } catch {
                print(error)
            }
        }

    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

