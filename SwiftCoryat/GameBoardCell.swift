//
//  GameBoardCell.swift
//  SwiftCoryat
//
//  Created by Michael Frain on 7/21/14.
//  Copyright (c) 2014 Michael Frain. All rights reserved.
//

import Foundation
import UIKit

class GameBoardCell: UICollectionViewCell {
    var cellValueString: String = "ABC"
    var alreadySelected = false
    
    @IBOutlet  var cellValueLabel: UILabel! = UILabel()
    
    class func cellForCollectionView(collectionView: UICollectionView, indexPath: NSIndexPath, cellValue: NSString) -> GameBoardCell {
        var newCell: GameBoardCell = collectionView.dequeueReusableCellWithReuseIdentifier("GameBoardCell", forIndexPath: indexPath) as GameBoardCell
        
        newCell.cellValueLabel.text = cellValue
        
        return newCell as GameBoardCell
    }
    /* This is all not working yet - but it will
    init(coder aDecoder: NSCoder!)  {
        super.init(coder: aDecoder)
        NSObject.addObserver(self, forKeyPath: "cellValueString", options: NSKeyValueObservingOptions.Initial, context: nil)
    }
    
    func deinitialize () {
        NSObject.removeObserver(self, forKeyPath: "cellValueString")
    }
    
    override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: [NSObject : AnyObject]!, context: UnsafePointer<()>) {
        if keyPath == "cellValueString" {
            cellValueLabel.text = cellValueString
        }
    }*/
}