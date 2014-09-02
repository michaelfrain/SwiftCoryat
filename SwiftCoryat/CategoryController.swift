//
//  CategoryController.swift
//  SwiftCoryat
//
//  Created by Michael Frain on 7/24/14.
//  Copyright (c) 2014 Michael Frain. All rights reserved.
//

import Foundation
import UIKit

class CategoryController: UIViewController, UITextFieldDelegate {
    @IBOutlet var cat1TextField: UITextField!
    @IBOutlet var cat2TextField: UITextField!
    @IBOutlet var cat3TextField: UITextField!
    @IBOutlet var cat4TextField: UITextField!
    @IBOutlet var cat5TextField: UITextField!
    @IBOutlet var cat6TextField: UITextField!
    var isRound2 = false
    var gameStatus = GameStatus()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidAppear(animated: Bool) {
        cat1TextField.text = ""
        cat2TextField.text = ""
        cat3TextField.text = ""
        cat4TextField.text = ""
        cat5TextField.text = ""
        cat6TextField.text = ""
    }
    
    var categoryArray = ["A", "B", "C", "D", "E", "F"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func textFieldDidEndEditing(textField: UITextField!) {
        switch textField {
        case cat1TextField:
            categoryArray[0] = cat1TextField.text.capitalizedString
        case cat2TextField:
            categoryArray[1] = cat2TextField.text.capitalizedString
        case cat3TextField:
            categoryArray[2] = cat3TextField.text.capitalizedString
        case cat4TextField:
            categoryArray[3] = cat4TextField.text.capitalizedString
        case cat5TextField:
            categoryArray[4] = cat5TextField.text.capitalizedString
        case cat6TextField:
            categoryArray[5] = cat6TextField.text.capitalizedString
        default:
            return
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        switch textField {
        case cat1TextField:
            cat2TextField.becomeFirstResponder()
        case cat2TextField:
            cat3TextField.becomeFirstResponder()
        case cat3TextField:
            cat4TextField.becomeFirstResponder()
        case cat4TextField:
            cat5TextField.becomeFirstResponder()
        case cat5TextField:
            cat6TextField.becomeFirstResponder()
        case cat6TextField:
            cat6TextField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "BeginGameSegue" {
            var gameBoardController = segue.destinationViewController as GameBoardController
            gameBoardController.categoryArray = categoryArray
            if isRound2 == false {
                gameBoardController.roundNumber = 1
            } else {
                gameBoardController.roundNumber = 2
                gameBoardController.gameStatus = gameStatus
            }
        }
    }
    
    @IBAction func unwindForRound2(sender: UIStoryboardSegue!) {
        isRound2 = true
        var sourceController = sender.sourceViewController as GameBoardController
        gameStatus = sourceController.gameStatus
    }
}
