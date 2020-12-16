//
//  FinalViewController.swift
//  AnimalsQuiz
//
//  Created by Евгений Прохоров on 11.12.2020.
//

import UIKit

class FinalViewController: UIViewController {
    
    var answerArray: [Answer]?
    
    let questions = Question.getQuestions()
    
    var countAnimalCat = 0
    var countAnimalDog = 0
    var countAnimalRabbit = 0
    var countAnimalTurtle = 0
    
    @IBOutlet var resultAnswerLabel: UILabel!
    @IBOutlet var animalScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        guard let answers = answerArray else { return }
        for answer in answers {
            resultAnswerLabel.text! += "\(answer.text) \n"
            if answer.type == .cat {
                countAnimalCat += 1
            } else if answer.type == .dog{
                countAnimalDog += 1
            } else if answer.type == .rabbit {
                countAnimalRabbit += 1
            } else if answer.type == .turtle {
                countAnimalTurtle += 1
            }
        }
        
        if countAnimalCat >= countAnimalDog && countAnimalCat >= countAnimalTurtle && countAnimalCat >= countAnimalRabbit {
            animalScoreLabel.text! += "Кошка \(countAnimalCat)"
        } else if countAnimalDog >= countAnimalCat && countAnimalDog >= countAnimalTurtle && countAnimalDog >= countAnimalRabbit {
            animalScoreLabel.text! += "Собака \(countAnimalDog)"
        } else if countAnimalRabbit >= countAnimalCat && countAnimalRabbit >= countAnimalTurtle && countAnimalRabbit >= countAnimalDog {
            animalScoreLabel.text! += "Кролик \(countAnimalRabbit)"
        } else if countAnimalTurtle >= countAnimalCat && countAnimalTurtle >= countAnimalDog && countAnimalTurtle >= countAnimalRabbit {
            animalScoreLabel.text! += "Черепаха \(countAnimalTurtle)"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
