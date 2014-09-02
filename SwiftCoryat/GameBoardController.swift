//
//  GameBoardController.swift
//  SwiftCoryat
//
//  Created by Michael Frain on 7/21/14.
//  Copyright (c) 2014 Michael Frain. All rights reserved.
//

import Foundation
import UIKit

class GameBoardController: UIViewController, UICollectionViewDelegate {
    var gameStatus = GameStatus()
    @IBOutlet var gameBoard: UICollectionView!
    @IBOutlet var endRound: UIButton!
    @IBOutlet var currentScore: UILabel!
    var categoryArray: Array<String>
    var roundNumber = 1
    var selectedCell: NSIndexPath!
    
    required init(coder aDecoder: NSCoder) {
        categoryArray = []
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentScore.text = "Score: \(gameStatus.currentScore) - Record: \(gameStatus.correctResponses) / \(gameStatus.incorrectResponses) / \(gameStatus.nonResponses)"
        if roundNumber == 1 {
            endRound.setTitle("End Round 1", forState: UIControlState.Normal)
        } else {
            endRound.setTitle("End Round 2", forState: UIControlState.Normal)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell {
        var cellValueString: String
        if roundNumber == 1 {
            switch indexPath.item {
            case 0...5:
                cellValueString = categoryArray[indexPath.item]
            case 6...11:
                cellValueString = "$200"
            case 12...17:
                cellValueString = "$400"
            case 18...23:
                cellValueString = "$600"
            case 24...29:
                cellValueString = "$800"
            case 30...35:
                cellValueString = "$1000"
            default:
                cellValueString = " "
            }
        } else {
            switch indexPath.item {
            case 0...5:
                cellValueString = categoryArray[indexPath.item]
            case 6...11:
                cellValueString = "$400"
            case 12...17:
                cellValueString = "$800"
            case 18...23:
                cellValueString = "$1200"
            case 24...29:
                cellValueString = "$1600"
            case 30...35:
                cellValueString = "$2000"
            default:
                cellValueString = " "
            }
        }
        let sampleCell = GameBoardCell.cellForCollectionView(collectionView, indexPath: indexPath, cellValue: cellValueString)
        
        return sampleCell
    }
    
    var selectedClue: Int = 0
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        var gameBoardCell = collectionView.cellForItemAtIndexPath(indexPath) as GameBoardCell
        if gameBoardCell.alreadySelected == true {
            return
        }
        if roundNumber == 1 {
            switch (indexPath.item) {
            case 6...11:
                selectedClue = 200
            case 12...17:
                selectedClue = 400
            case 18...23:
                selectedClue = 600
            case 24...29:
                selectedClue = 800
            case 30...35:
                selectedClue = 1000
            default:
                selectedClue = 0
            }
        } else {
            switch (indexPath.item) {
            case 6...11:
                selectedClue = 400
            case 12...17:
                selectedClue = 800
            case 18...23:
                selectedClue = 1200
            case 24...29:
                selectedClue = 1600
            case 30...35:
                selectedClue = 2000
            default:
                selectedClue = 0
            }
        }
        selectedCell = indexPath
        if indexPath.item > 5 {
            self.performSegueWithIdentifier("CellSelectionSegue", sender: self)
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        if identifier == "UnwindRoundSegue" && roundNumber == 2 {
            return false
        } else if identifier == "FinalJeopardySegue" && roundNumber == 1 {
            return false
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "CellSelectionSegue" {
            var destinationController: ResultController = segue.destinationViewController as ResultController
            destinationController.gameStatus = self.gameStatus
            destinationController.currentClueValue = selectedClue
            destinationController.cellIndexPath = selectedCell
        } else if segue.identifier == "FinalJeopardySegue" {
            var destinationController: FinalJeopardyController = segue.destinationViewController as FinalJeopardyController
            destinationController.finalStatus = gameStatus
        }
    }
    
    @IBAction func unwindConfirmedClueResult(sender: UIStoryboardSegue!) {
        var sourceController = sender.sourceViewController as ResultController
        var previousCellIndex = sourceController.cellIndexPath
        var previousCell = gameBoard.cellForItemAtIndexPath(previousCellIndex) as GameBoardCell
        if sourceController.result == ResultController.LastResult.Correct {
            previousCell.cellValueLabel.textColor = UIColor.greenColor()
        } else if sourceController.result == ResultController.LastResult.Incorrect {
            previousCell.cellValueLabel.textColor = UIColor.redColor()
        } else {
            previousCell.cellValueLabel.textColor = UIColor.grayColor()
        }
        previousCell.alreadySelected = true
        self.gameStatus = sourceController.gameStatus
        currentScore.text = "Score: \(gameStatus.currentScore) - Record: \(gameStatus.correctResponses) / \(gameStatus.incorrectResponses) / \(gameStatus.nonResponses)"
    }
    
    @IBAction func unwindCanceledClueResult(sender: UIStoryboardSegue!) {
        var sourceController = sender.sourceViewController as ResultController
        var previousCellIndex = sourceController.cellIndexPath
        var previousCell = gameBoard.cellForItemAtIndexPath(previousCellIndex) as GameBoardCell
        previousCell.cellValueLabel.enabled = true
    }
    
    @IBAction func sendToFinalJeopardy(sender: UIButton!) {
        if roundNumber == 2 {
            self.performSegueWithIdentifier("FinalJeopardySegue", sender: self)
        }
    }
}
