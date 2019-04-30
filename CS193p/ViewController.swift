//
//  ViewController.swift
//  CS193p
//
//  Created by RoHIT on 30/04/19.
//  Copyright © 2019 RoHIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var displayLabel: UILabel!
	var userIsInMiddleOfTyping: Bool = false
	@IBAction func touchDigit(_ sender: UIButton) {
		let digit = sender.currentTitle!
		if userIsInMiddleOfTyping {
			let textCurrentlyInDisplay = displayLabel.text!
			displayLabel.text = textCurrentlyInDisplay + digit
		}else{
			displayLabel.text = digit
			userIsInMiddleOfTyping = true
		}
		
	}
	
	var displayValue: Double{
		get{
			return Double(displayLabel.text!)!
		}set{
			displayLabel.text = String(newValue)
		}
	}
	
	@IBAction func performOperation(_ sender: UIButton) {
		userIsInMiddleOfTyping = false
		if let mathematicalSymbol = sender.currentTitle{
			switch mathematicalSymbol{
			case "\u{10}π":
				displayValue = Double.pi
			case "√":
			displayValue = sqrt(displayValue)
			default: break
			}
		}
		
	}
	
}

