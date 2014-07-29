//
//  GameStatus.swift
//  SwiftCoryat
//
//  Created by Michael Frain on 7/24/14.
//  Copyright (c) 2014 Michael Frain. All rights reserved.
//

import Foundation

class GameStatus {
    var currentScore: Int = 0
    
    var correctResponses: Int = 0
    var incorrectResponses: Int = 0
    var nonResponses: Int = 0
    
    var dailyDoubleRight: Int = 0
    var dailyDoubleWrong: Int = 0
    
    var lachTrashPickedUp: Int = 0
    var slowReluctantRight: Int = 0
    var slowReluctantNoAnswer: Int = 0
}