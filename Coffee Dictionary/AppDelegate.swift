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

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        let db = Firestore.firestore()

        GADMobileAds.sharedInstance().start(completionHandler: nil)

        // Realm file location.
        print("RealmDBLocation: \(Realm.Configuration.defaultConfiguration.fileURL)")
        do {
            // Init realm and keep this for be able to see possible errors.
            // It's not in use so keep it as a _
            _ = try Realm()
        } catch {
            print("Error initializing new realm : \(error)")
        }
        
        
        
        return true
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

