//
//  Blog.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 4.03.2023.
//

import UIKit
import Foundation
import FirebaseFirestore




struct Blog {
    
    var title : String = ""
    var blogPost : String = ""
    var createdAt = String()
    var imageUrl = String()
   // var image = UIImage()
    
    
    
    static func parseBlogPost(_ document: QueryDocumentSnapshot) -> Blog {
        
        var newBlogPost = Blog()
        
        if let blogPost = document.data()["blogPost"] as? String {
            if let title = document.data()["title"] as? String {
                if let imageUrl = document.data()["imageUrl"] as? String {
                    if let createdAt = document.data()["createdAt"] as? Timestamp {
                        let date = self.formatDate(dateToFormat: createdAt.dateValue())
                
                        
                        newBlogPost = Blog(title: title,
                                           blogPost: blogPost,
                                           createdAt: date,
                                           imageUrl: imageUrl)
                        
                    }
                }
            }
        }
        return newBlogPost

    }
    
    
    
    static func formatDate(dateToFormat: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "MMM d"
        let formattedDate = df.string(from: dateToFormat)
        return formattedDate
    }
    
}
