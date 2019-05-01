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
	
	
	private var brain = CalculatorBrain()
	
	@IBAction func performOperation(_ sender: UIButton) {
		
		if userIsInMiddleOfTyping{ // Check if user have value
			brain.setOperand(displayValue)
			userIsInMiddleOfTyping = false // let user enter new value
		}
		
		if let mathematicalSymbol = sender.currentTitle{
			brain.performOperation(mathematicalSymbol)
		}
		
		if let result = brain.result{
			displayValue = result
		}
		
		
	}
	
}

