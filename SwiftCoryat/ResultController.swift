//
//  ResultController.swift
//  SwiftCoryat
//
//  Created by Michael Frain on 7/22/14.
//  Copyright (c) 2014 Michael Frain. All rights reserved.
//

import Foundation
import UIKit

class ResultController: UIViewController {
    var gameStatus = GameStatus()
    var currentClueValue: Int = 0
    
    enum LastResult {
        case Correct
        case Incorrect
        case NoAnswer
    }
    
    var result = LastResult.NoAnswer
    
    @IBOutlet var currentScoreLabel: UILabel!
    @IBOutlet var currentClueLabel: UILabel!
    @IBOutlet var newScoreLabel: UILabel!
    @IBOutlet var responseLabel: UILabel!
    
    @IBOutlet var dailyDoubleSwitch: UISwitch?
    @IBOutlet var tripleStumperSwitch: UISwitch?
    @IBOutlet var slowReluctantSwitch: UISwitch?
    
    @IBOutlet var clueResultSegmentedControl: UISegmentedControl?
    
    var cellIndexPath = NSIndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        clueResultSegmentedControl?.addTarget(self, action:Selector.convertFromStringLiteral("clueResultSelected:"), forControlEvents: UIControlEvents.ValueChanged)
        self.currentScoreLabel.text = "Current total: $\(gameStatus.currentScore)"
        self.currentClueLabel.text = "Current clue: $\(currentClueValue)"
        self.newScoreLabel.hidden = true
        self.responseLabel.hidden = true
    }
    
    @IBAction func cancelClue() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func clueResultSelected(sender: UISegmentedControl!) {
        switch sender.selectedSegmentIndex {
        case 0:
            responseLabel.hidden = false
            responseLabel.text = "Correct response: +$\(currentClueValue)"
            newScoreLabel.hidden = false
            newScoreLabel.text = "New total: $\(gameStatus.currentScore + currentClueValue)"
            result = LastResult.Correct
        case 1:
            responseLabel.hidden = false
            newScoreLabel.hidden = false
            if dailyDoubleSwitch!.on == false {
                responseLabel.text = "Incorrect response: -$\(currentClueValue)"
                newScoreLabel.text = "New total: $\(gameStatus.currentScore - currentClueValue)"
                result = LastResult.Incorrect
            } else {
                responseLabel.text = "Incorrect response: $0"
                newScoreLabel.text = "New total: $\(gameStatus.currentScore)"
                result = LastResult.NoAnswer
            }
        case 2:
            responseLabel.hidden = false
            responseLabel.text = "No response: $0"
            newScoreLabel.hidden = false
            newScoreLabel.text = "New total: $\(gameStatus.currentScore)"
        default:
            return
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        if identifier == "UnwindConfirmedClueSegue" {
            if clueResultSegmentedControl!.selectedSegmentIndex == -1 {
                let alert = UIAlertController(title: "Wait!", message: "You have to select an outcome of the current clue, or cancel.", preferredStyle: UIAlertControllerStyle.Alert)
                let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
                alert.addAction(dismissAction)
                self.presentViewController(alert, animated: true, completion: nil)
                return false
            }
        } else if identifier == "UnwindCanceledClueSegue" {
            // Nothing needs to be done here yet, but Swift requires this case here
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "UnwindConfirmedClueSegue" {
            switch clueResultSegmentedControl!.selectedSegmentIndex {
            case 0:
                gameStatus.currentScore += currentClueValue
                gameStatus.correctResponses++
                if dailyDoubleSwitch?.on == true {
                    gameStatus.dailyDoubleRight++
                }
                if tripleStumperSwitch?.on == true {
                    gameStatus.lachTrashPickedUp += currentClueValue
                }
                if slowReluctantSwitch?.on == true {
                    gameStatus.slowReluctantRight++
                }
            case 1:
                if dailyDoubleSwitch?.on == false {
                    gameStatus.currentScore -= currentClueValue
                    gameStatus.incorrectResponses++
                } else {
                    gameStatus.nonResponses++
                    gameStatus.dailyDoubleWrong++
                }
            default:
                gameStatus.nonResponses++
            }
        }
    }
    
    @IBAction func dailyDoubleChange(sender: UISwitch!) {
        self.clueResultSelected(clueResultSegmentedControl)
    }
}