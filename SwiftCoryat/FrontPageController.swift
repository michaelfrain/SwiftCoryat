//
//  FrontPageController.swift
//  SwiftCoryat
//
//  Created by Michael Frain on 8/2/14.
//  Copyright (c) 2014 Michael Frain. All rights reserved.
//

import Foundation
import UIKit

class FrontPageController: UIViewController {
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var typeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let today = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY"
        let dateString = formatter.stringFromDate(today)
        dateButton.setTitle(dateString, forState: .Normal)
        dateButton.titleLabel!.textColor = UIColor.whiteColor()
    }
}