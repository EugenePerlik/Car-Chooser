//
//  Question.swift
//  Car Chooser
//
//  Created by Nikita Somenkov on 05/12/2018.
//  Copyright © 2018 Nikita Somenkov. All rights reserved.
//

import Foundation

enum Brand : Int {
    case bmw, mercedes, audi, volkswagen
    case hyundai, toyota, kia, honda, nissan
    case ford, chevrolet
    
    static var humanReadableMap: [Brand: String] = [
        .bmw: "BMW",
        .mercedes: "Mercedes-Benz"
    ]
    
    var name: String {
        let result = Brand.humanReadableMap[self] ?? "\(self)"
        return result.prefix(1).uppercased() + result.dropFirst()
    }
}

struct Score {
    let brand: Brand
    let score: Int
}

struct Scores {
    let scores: [Score]
    
    static func scores(for brands: [Brand], _ score: Int) -> Scores {
        let scores = brands.map {
            return Score(brand: $0, score: score)
        }
        return Scores(scores: scores)
    }
}

struct ChooseVariant {
    let variant: String
    let scores: Scores
    
    static func withVariant(_ variant: String, _ scores: Scores) -> ChooseVariant {
        return ChooseVariant(variant: variant, scores: scores)
    }
}

enum QuestionType {
    case choose([ChooseVariant])
}

enum Answer {
    case choose(Int)
}

struct Question {
    let question: String
    let imageName: String?
    let type: QuestionType
}

struct Result {
    var brands: [Brand]
}

class Questions {
    private(set) var position: Int = 0
    private(set) var scores: [Brand: Int] = [:]
    private(set) var questions = [
        Question(question: "What is important for you in cars?", imageName: nil, type:
            .choose([
                .withVariant("Design",
                             .scores(for:  [.bmw, .mercedes, .audi, .hyundai, .honda], 3)),
                .withVariant("Reliability",
                             .scores(for: [.toyota, .ford, .chevrolet], 3)),
                .withVariant("Cost",
                             .scores(for: [.hyundai, .kia, .volkswagen], 3))
            ])
        ),
        Question(question: "How often come into conflict?", imageName: nil, type:
            .choose([
                .withVariant("Yes, of course",
                             .scores(for: [.bmw, .toyota, .honda], 3)),
                .withVariant("No, I try to avoid them.",
                             .scores(for: [.hyundai, .kia, .volkswagen], 3))
                ])
        ),
        Question(question: "What is closer to you?", imageName: nil, type:
            .choose([
                .withVariant("Money, Authority",
                             .scores(for: [.bmw, .toyota, .honda], 3)),
                .withVariant("Nature, Family",
                             .scores(for: [.hyundai, .kia, .volkswagen, .ford, .chevrolet], 3))
                ])
        ),
    ]
    
    var currentQuestion: Question? {
        if questions.indices ~= position {
            return questions[position]
        }
        return nil
    }
    
    func answer(_ answer: Answer) {
        switch answer {
        case .choose(let chooseIndex):
            
            updateChooseScores(chooseIndex)
        }
    }
    
    private func updateChooseScores(_ choose: Int) {
        guard let currentQuestion = currentQuestion else {
            return
        }
    
        switch (currentQuestion.type) {
        case .choose(let chooses):
            if chooses.indices ~= choose {
                for score in chooses[choose].scores.scores {
                    if !self.scores.keys.contains(score.brand) {
                        self.scores[score.brand] = 0
                    }
                    self.scores[score.brand]? += score.score
                }
            }
        }
    }
    
    func backQuestion() -> Question? {
        position -= 1
        return currentQuestion
    }
    
    func nextQuestion() -> Question? {
        position += 1
        return currentQuestion
    }
    
    var result: Result {
        var brands = [Brand]()
        let maxScore = self.scores.values.max()
        for (brand, score) in self.scores {
            if score == maxScore {
                brands.append(brand)
            }
        }
        return Result(brands: brands)
    }
}
