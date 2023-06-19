//
//  Badge.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 11.06.2023.
//

import Foundation
import CoreData
import UIKit

struct Badge : Codable {

    let name : String
    let subText : String
    let imageUrl : String
    
    
    public static func getBadgeFromObject(object : [String : Any]) -> Badge? {
        
        let newBadge = Badge(name: object["name"] != nil ? object["name"] as! String : "",
                             subText: object["subText"] != nil ? object["subText"] as! String : "",
                             imageUrl: object["imageUrl"] != nil ? object["imageUrl"] as! String : "")
        
        return newBadge
    }
    
    
    
    
    /// Get available badges from db and append them in an array.
    public static func fetchCurrentBadges(currentQuizzes: [Quiz]?, isForSingleBadge: Bool) -> [Badge]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var context : NSManagedObjectContext!
        var badgesArray = [Badge]()
        /// Create fetch request for Badge entity.
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Badge.entityBadges)
        request.returnsObjectsAsFaults = false
        context = appDelegate.persistentContainer.viewContext
        do {
            let result = try context.fetch(request)
            /// Get results from context and check if is there available badges or not.
            if let result = result as? [NSManagedObject] {
                if result.count != 0 {
                    /// User has at least one badge.
                    for data in result {
                        createBadgeFromCoreData(data, &badgesArray)
                    }
                    if isForSingleBadge {
                        if let currentQuizzes = currentQuizzes {
#warning("This part should be dynamic. For now it's just working. It's showing still a badge even all quizzes has solved.")
                            if badgesArray.count != 16 {
                                appendLastBadge(currentQuizzes, &badgesArray)
                            }
                        }
                    }
                    return badgesArray
                } else {
                    /// There's no available badge found. Show first badge to encourage.
                    print("No data came ")
                    if isForSingleBadge {
                        if let currentQuizzes = currentQuizzes {
                            if let firstBadge = currentQuizzes.first?.badge {
                                badgesArray.append(firstBadge)
                            } else {
                                /// For any case of, create simple default badge.
                                badgesArray.append(Badge(name: "New badge",
                                                         subText: "Keep up.",
                                                         imageUrl: ""))
                            }
                        }}
                }
            }
        } catch {
            print("Fetching data Failed: \(error.localizedDescription)")
        }
        return badgesArray
    }
    
    fileprivate static func createBadgeFromCoreData(_ data: NSManagedObject, _ badgesArray: inout [Badge]) {
        let name = data.value(forKey: Constants.Badge.name) as! String
        let subText = data.value(forKey: Constants.Badge.subText) as! String
        let imageUrl = data.value(forKey: Constants.Badge.imageUrl) as! String
        /// Create user's badge and append it into array.
        let newBadge = Badge(name: name,
                             subText: subText,
                             imageUrl: imageUrl)
        print("Data fetched \(newBadge)")
        badgesArray.append(newBadge)
    }
    
    fileprivate static func appendLastBadge(_ currentQuizzes: [Quiz], _ badgesArray: inout [Badge]) {
        /// Check is there one more badge than user has. If yes, show this badge to encourage.
        if let nextBadge = currentQuizzes[badgesArray.count].badge {
            badgesArray.append(nextBadge)
        }
    }
    
}



