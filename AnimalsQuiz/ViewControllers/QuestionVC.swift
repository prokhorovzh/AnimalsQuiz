//
//  QuestionVC.swift
//  AnimalsQuiz
//
//  Created by Евгений Прохоров on 11.12.2020.
//

import UIKit

class QuestionVC: UIViewController {
    
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var rangedSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            rangedSlider.value = answerCount
        }
    }
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var rangeStackView: UIStackView!
    
    @IBOutlet var singleButtons: [UIButton]!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var rangedLabels: [UILabel]!
    
    @IBOutlet var multipleSwitches: [UISwitch]!
    //MARK: Properties
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var answerChosen: [Answer] = []
    private var currentAnswers: [Answer] { questions[questionIndex].answer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    @IBAction func singleButtonAnswerPressed(_ sender: UIButton) {
        guard let currentIndex = singleButtons.firstIndex(of: sender) else { return }
            
            let currentAnswer = currentAnswers[currentIndex]
            answerChosen.append(currentAnswer)
            
            nextQuestion()
    }
    
    @IBAction func multipleAnswerPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answerChosen.append(answer)
            }
        }
        
        nextQuestion()
    }
    
    @IBAction func rangeAnswerPressed() {
        
        let index = Int(rangedSlider.value)
        answerChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard segue.identifier == "showResult" else { return }
            guard let destination = segue.destination as? FinalViewController else { return }
        destination.answerArray = answerChosen
        }
    
}

//MARK: Private
extension QuestionVC {
    private func updateUI() {
        for stackView in [singleStackView, multipleStackView, rangeStackView] {
            stackView?.isHidden = true
        }
        
        let currentQuestion = questions[questionIndex]
        
        questionLabel.text = currentQuestion.text
        
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        progressView.setProgress(totalProgress, animated: true)
        
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        showCurrentStackView(for: currentQuestion.type)
    }
    
    private func showCurrentStackView(for type: ResponseType) {
        switch type {
        case .single:
            showSingleStackView(with: currentAnswers)
        case .multiple:
            showMultipleStackView(with: currentAnswers)
        case .range:
            showRangedStackView(with: currentAnswers)
        }
    }
    
    private func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden = false
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.text, for: .normal)
        }
    }
    
    private func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden = false
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.text
        }
    }
    
    private func showRangedStackView(with answers: [Answer]) {
        rangeStackView.isHidden = false
        
        rangedLabels.first?.text = answers.first?.text
        rangedLabels.last?.text = answers.last?.text
    }
    
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}
