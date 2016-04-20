//
//  GameTypeController.swift
//  SwiftCoryat
//
//  Created by Michael Frain on 8/19/14.
//  Copyright (c) 2014 Michael Frain. All rights reserved.
//

import Foundation
import UIKit

class GameTypeController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet var gameTypePicker: UIPickerView!
    
    enum GameTypes {
        case RegularPlay
        case TournamentOfChampions
        case TeenTournament
        case KidsWeek
        case OtherSpecial
        case OtherSpecialTournament
        case NumberOfTypes
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GameTypes.NumberOfTypes.hashValue
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var typeName: String
        switch row {
        case GameTypes.RegularPlay.hashValue:
            typeName = "Regular Play"
            
        case GameTypes.TournamentOfChampions.hashValue:
            typeName = "Tournament of Champions"
            
        case GameTypes.TeenTournament.hashValue:
            typeName = "Teen Tournament"
            
        case GameTypes.KidsWeek.hashValue:
            typeName = "Kids Week"
            
        case GameTypes.OtherSpecial.hashValue:
            typeName = "Special (Non-Tournament)"
            
        case GameTypes.OtherSpecialTournament.hashValue:
            typeName = "Special (Tournament)"
            
        default:
            typeName = "Unknown"
        }
        return typeName
    }
}