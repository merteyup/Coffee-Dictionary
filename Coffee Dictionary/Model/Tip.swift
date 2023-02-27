//
//  Tip.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 22.02.2023.
//

import Foundation
import RealmSwift


// Subclass and create realm object.
class Tip : Object {
    // Specify properties for class. With @objc dynamic key, we keep it updated dynamically.
    @objc dynamic var id : Int = 0
    @objc dynamic var tip : String = ""
    @objc dynamic var tipDescription : String = ""
    @objc dynamic var isViewed : Int = 0

}
