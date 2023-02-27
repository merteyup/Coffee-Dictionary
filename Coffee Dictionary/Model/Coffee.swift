//
//  Coffee.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 13.02.2023.
//

import Foundation
import RealmSwift


// Subclass and create realm object.
class Coffee : Object {
    // Specify properties for class. With @objc dynamic key, we keep it updated dynamically.
    @objc dynamic var name : String = ""
    @objc dynamic var roaster : String = ""
    @objc dynamic var roast : String = ""
    @objc dynamic var origin_1 : String = ""
    @objc dynamic var rating : Int = 0
    @objc dynamic var desc_1 : String = ""
    @objc dynamic var desc_2 : String = ""
    @objc dynamic var desc_3 : String = ""
    @objc dynamic var isFavorite : Int = 0
    
}

