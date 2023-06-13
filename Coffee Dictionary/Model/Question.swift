//
//  Question.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 4.04.2023.
//

import Foundation


struct QuestionsArray {
    
    var questionsArray : [[String : Any]]
    
}

struct Quiz {
    
    var singleQuiz : [Question]?
    var id : String?
    var isSolved : Bool?
    var quizTopic : String?
    var badge : Badge?
    
}

struct Question {
    
    var questionText : String?
    var answers : [String]?
    var correctAnswer : String?
    var isAnswered : Bool?
    var isCorrectAnswered : Bool?
    
    public static func getQuizzesFromObject(object : [String : Any], documentId: String) -> Quiz? {
        
        var returningQuiz = Quiz()
            
            if let newQuizes = object["questionsArray"] as? [[String : Any]] {
                 let quizTopic = object["quizTopic"] != nil ? object["quizTopic"] as! String : ""
                if let newBadge = object["badge"] as? [String : Any] {
                    
                    let newQuiz = Quiz(singleQuiz: getQuestionFromObject(object: newQuizes),
                                       id: documentId,
                                       isSolved: nil,
                                       quizTopic: quizTopic,
                                       badge: Badge.getBadgeFromObject(object: newBadge))
                    
                   returningQuiz = newQuiz
                    
                    print("GelenQuiz: \(newQuiz)")
                } else {
                    #warning("This is necessery for now. Because currently not all quizes has a badge. Start adding badges to all of them.")
                    let newQuiz = Quiz(singleQuiz: getQuestionFromObject(object: newQuizes),
                                       id: documentId,
                                       isSolved: nil,
                                       quizTopic: quizTopic)
                    
                   returningQuiz = newQuiz
                }
                
                
                    
                  
                  
                
                print("CountCount1: \(returningQuiz.id)")
                
            }
        
        
        return returningQuiz
    }
    
    public static func getQuestionFromObject(object : [[String : Any]]) -> [Question]? {
        
        var returningQuestions = [Question]()
            
        for singleObject in object {
            print("CountCount2: \(singleObject)")

            let newQuestion = Question(questionText: singleObject["questionText"] != nil ? singleObject["questionText"] as! String : "",
                                       answers: singleObject["answers"] != nil ? singleObject["answers"] as! [String] : [""],
                                       correctAnswer: singleObject["correctAnswer"] != nil ? singleObject["correctAnswer"] as! String : "")
            returningQuestions.append(newQuestion)
          
        }

         
        
        
        return returningQuestions
    }
    
}




