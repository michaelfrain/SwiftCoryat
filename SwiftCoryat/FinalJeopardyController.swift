//
//  FinalJeopardyController.swift
//  SwiftCoryat
//
//  Created by Michael Frain on 7/24/14.
//  Copyright (c) 2014 Michael Frain. All rights reserved.
//

import Foundation
import UIKit

class FinalJeopardyController: UIViewController {
    var finalStatus = GameStatus()
    @IBOutlet var responseField: UITextField!
    @IBOutlet var lockButton: UIButton!
    @IBOutlet var correctResponseButton: UIButton!
    @IBOutlet var incorrectResponseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func lockAnswer(sender: UIButton) {
        let alert = UIAlertController(title: "Wait!", message: "Once you lock your response, you cannot reverse this. Are you sure?", preferredStyle: .Alert)
        let confirm = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Default, handler:{
            self.responseField.enabled = false
            self.lockButton.enabled = false
            self.lockButton.setTitle("Response Locked", forState: UIControlState.Disabled)
            return nil
        }())
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(confirm)
        alert.addAction(cancel)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func setResponseValue(sender: UIButton) {
        if sender == self.correctResponseButton {
            finalStatus.finalJeopardyCorrect = true
        } else if sender == self.incorrectResponseButton {
            finalStatus.finalJeopardyCorrect = false
        }
        self.performSegueWithIdentifier("GameSummarySegue", sender: sender)
    }
    
    override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
        
    }
}
