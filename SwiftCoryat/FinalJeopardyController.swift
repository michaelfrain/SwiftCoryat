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
    @IBOutlet var questionRecord: UILabel!
    @IBOutlet var coryatScore: UILabel!
    @IBOutlet var dailyDoubleRecord: UILabel!
    @IBOutlet var lachTrashScore: UILabel!
    var finalStatus = GameStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        questionRecord.text = "Question record: \(finalStatus.correctResponses)/\(finalStatus.incorrectResponses)/\(finalStatus.nonResponses)"
        coryatScore.text = "Coryat Score: \(finalStatus.currentScore)"
        dailyDoubleRecord.text = "Daily Double record: \(finalStatus.dailyDoubleRight)/\(finalStatus.dailyDoubleWrong)"
        lachTrashScore.text = "Lach Trash picked up: \(finalStatus.lachTrashPickedUp)"
    }
}
