//
//  CalculatorBrain.swift
//  CS193p
//
//  Created by RoHIT on 01/05/19.
//  Copyright © 2019 RoHIT. All rights reserved.
//

import Foundation
struct CalculatorBrain {
	private var accumulator: Double?
	private typealias Doubler = (Double,Double) -> Double
	private enum Operation{
		case constantOperation(Double)
		case unaryOperation((Double) -> Double)
		case binary(Doubler)
		case equal
	}
	
	private var operations: [String: Operation] = [
		"\u{10}π": .constantOperation(Double.pi),
		"e": .constantOperation(M_E),
		"√": .unaryOperation(sqrt),
		"cos": .unaryOperation(cos),
		"±": .unaryOperation{ -$0 },
		"×": .binary{ $0 * $1 },
		"=": .equal,
		"−": .binary{ $0 - $1 },
		"÷": .binary{ $0 / $1 },
		"+": .binary{ $0 + $1 }
		
	]
	
	mutating func performOperation(_ symbol: String){
		if let constant = operations[symbol]{
			switch constant{
			case .constantOperation(let value):
				accumulator = value
			case .unaryOperation(let squareRoot):
				if let constant = accumulator{
					accumulator = squareRoot(constant)
				}
			case .binary(let function):
				if accumulator != nil{
					pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
					accumulator = nil
				}
			case .equal:
				performBinaryOperation()
				break
			}
		}

	} 
	
	
	mutating func performBinaryOperation(){
		if accumulator != nil && pendingBinaryOperation != nil{
			accumulator = pendingBinaryOperation?.perform(with: accumulator!)
			pendingBinaryOperation = nil
		}
	}
	
	mutating func setOperand(_ operand: Double){
		accumulator = operand
	}
	
	
	private var pendingBinaryOperation: PendingBinaryOperation?
	
	private struct PendingBinaryOperation{
		let function: Doubler
		let firstOperand: Double
		
		func perform(with secondOperand: Double) -> Double{
			return function(firstOperand,secondOperand)
		}
	}
	

	
	var result: Double?{
		get{
			return accumulator
		}
	}
	
}

//Global function

// if we put inside it will be (CalculatorBrain) -> (Double) -> Double
//func changeSign(operand: Double) -> Double{
//	return -operand
//}
//
//func multiply(op1: Double, op2: Double) -> Double{
//	return op1 * op2
//}

