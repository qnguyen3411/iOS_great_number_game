//
//  ViewController.swift
//  great_number_game
//
//  Created by Quang Nguyen on 9/4/18.
//  Copyright © 2018 Quang Nguyen. All rights reserved.
//

import UIKit

enum Outcome:String {
  case notANumber = "u didn't enter a number!"
  case tooHigh = "2high!"
  case tooLow = "2low!"
  case correct = "Yayyyyy u got it rite"
}


class ViewController: UIViewController {
  
  // Text field where user inputs their guess
  @IBOutlet weak var inputText: UITextField!
  
  // Event listener for submit button
  @IBAction func submitButtonPressed(_ sender: UIButton) {
    
    // Read user input, determine outcome
    let outcome = compareUserGuess(inputText.text, to: answer)
    
    // Reset text field
    inputText.text = ""
    
    // If outcome is correct, start new game
    if outcome == .correct {
      answer =  Int.random(in: lowBound...upBound)
    }
    
    // Create an alert according to the outcome
    let alert = makeAlert(from: outcome)
    
    // Show alert
    self.present(alert, animated: true, completion: nil)
    
  }
  
  var answer = 0
  let lowBound = 0
  let upBound = 100
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    answer =  Int.random(in: lowBound...upBound)

  }
  
  
  // Parse user input string into int and compare to answer
  func compareUserGuess(_ guess:String?, to answer: Int) -> Outcome {
    if let unwrappedGuess = guess {
      
      // If guess isn't nil
      if let numberGuess = Int(unwrappedGuess){
        
        // If guess is a valid number
        if numberGuess < answer {
          return Outcome.tooLow
        } else if numberGuess > answer {
          return Outcome.tooHigh
        } else {
          return Outcome.correct
        }
      }
    }
    return Outcome.notANumber
    
  }
  
  //Returns an alert view object according to outcome
  func makeAlert(from outcome: Outcome) -> UIAlertController {
    
    // Prepare alert input
    var alertTitle = ""
    var alertActionTitle = ""

    if outcome == .correct {
      alertTitle = "Correct"
      alertActionTitle = "Play again"
    } else {
      alertTitle = "Incorrect"
      alertActionTitle = "Guess again"
    }
    
    // Make alert view
    let alert = UIAlertController(
      title: alertTitle,
      message: outcome.rawValue,
      preferredStyle: UIAlertController.Style.alert
    )
    
    // Make alert action (button)
    alert.addAction(UIAlertAction(
      title: alertActionTitle,
      style: UIAlertAction.Style.default,
      handler: nil)
    )
    
    return alert
  }
  


}

