//
//  Calculator.swift
//  calc
//
//  Created by Jacktator on 31/3/20.
//  Copyright © 2020 UTS. All rights reserved.
//

import Foundation

class Calculator {
    
    /// For multi-step calculation, it's helpful to persist existing result
    var currentResult = 0;
    
    /// Perform Addition
    ///
    /// - Author: Jacktator
    /// - Parameters:
    ///   - no1: First number
    ///   - no2: Second number
    /// - Returns: The addition result
    ///
    /// - Warning: The result may yield Int overflow.
    /// - SeeAlso: https://developer.apple.com/documentation/swift/int/2884663-addingreportingoverflow

    func add(no1: Int, no2: Int) -> Int {
        return no1 + no2;
    }
    
    func calculate(args: [String]) -> String {
        // Todo: Calculate Result from the arguments. Replace dummyResult with your actual result;

        var newArray: [String] = args
        let firstActions: [String] = ["x","/","%"]
        let secondActions: [String] = ["+","-"]
        var result: Int = 0
        
        if args.count == 1{
            if let number = Int(args[0]){
                return "\(number)"
            }
        }
        
        var numbers: [Int] = []
        var operators: [String] = []
        
        for element in newArray{
            if let num = Int(element){
                numbers.append(num)
            } else {
                operators.append(element)
            }
        }
                
        if operators.count != 0{
            var currIndex: Int = 0
            while currIndex < operators.count{
                var op = operators[currIndex]
                if firstActions.contains(op){
                    var firstNum = numbers[currIndex]
                    var secondNum = numbers[currIndex+1]
                    var newNum: Int = 0
                    switch op{
                    case "x":
                        newNum = firstNum * secondNum
                    case "/":
                        newNum = firstNum / secondNum
                    case "%":
                        newNum = firstNum % secondNum
                    case "*":
                        newNum = firstNum * secondNum
                    default:
                        return String(numbers[1000])
                    }
                    numbers[currIndex] = newNum
                    numbers.remove(at: currIndex+1)
                    operators.remove(at: currIndex)
                } else {
                    currIndex += 1
                }
            }
            result += numbers[0]
        }

        if operators.count != 0{
            for i in 0..<operators.count{
                switch operators[i]{
                case "+":
                    result += numbers[i+1]
                case "-":
                    result -= numbers[i+1]
                default:
                    break;
                }
            }
        }
        return(String(result))
    }
}
