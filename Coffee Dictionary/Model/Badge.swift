//
//  Badge.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 11.06.2023.
//

import Foundation

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
    
}



