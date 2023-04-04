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

struct Question {
    
    
    var questionText : String?
    var answers : [String]?
    var correctAnswer : String?
    var isAnswered : Bool?
    
    public static func getQuestionFromObject(object : [String : Any]) -> [Question]? {
        
        var returningQuestions = [Question]()
        let questionsArray = object["questionsArray"] != nil ? object["questionsArray"] as! [[String : Any]] : []
        for question in questionsArray {
            let newQuestion = Question(questionText: question["questionText"] != nil ? question["questionText"] as! String : "",
                                       answers: question["answers"] != nil ? question["answers"] as! [String] : [""],
                                       correctAnswer: question["correctAnswer"] != nil ? question["correctAnswer"] as! String : "")
            returningQuestions.append(newQuestion)
        }
        return returningQuestions
    }
    
}




