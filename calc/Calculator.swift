//
//  Calculator.swift
//  calc
//
//  Created by Jacktator on 31/3/20.
//  Copyright © 2020 UTS. All rights reserved.
//

import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program

// Initialize a Calculator object
let calculator = Calculator();

// Calculate the result
let result = try calculator.calculate(args: args)
print(result)

class Calculator {

    //Initialize result where we store final evaluation of all operations
    var result: Int = 0
    
    //Create two separate arrays with valid operators to manage priority
    let firstActions: [String] = ["x","/","%"]
    let secondActions: [String] = ["+","-"]

    //Function to perform addition, substraction, multiplication, division, modulo
    func operation(no1: Int, no2: Int, op: String) -> Int{
        var result: Int = 0
        
        switch op{
            case "+": result = no1 + no2
            case "-": result = no1 - no2
            case "x": result = no1 * no2
            case "/": result = no1 / no2
            case "%": result = no1 % no2
            default: exit(-1)
        }

        return result;
    }

    //Function for error handling
    func errorHandling(array: [String]){
        //If no operators are included in the arguments throw error
        if array.count == 0{
            exit(-1)
        }

        //If invalid operators are included in the arguments throw error
        for op: String in array{
            if !firstActions.contains(op) && !secondActions.contains(op){
                exit(-1)
            }
        }
    }
    
    //Main function to calculate result
    func calculate(args: [String]) throws -> String {
        //Transfer arguments into a new variable 
        let newArray: [String] = args

        //If only one argument was provided and can be converted to String, return this element        
        if args.count == 1{
            if let number = Int(args[0]){
                return "\(number)"
            }
        }

        //Divide elemets of array into separate arrays of numbers and operators
        var numbers: [Int] = []
        var operators: [String] = []
        for element: String in newArray{
            //Loop through each given argument (Array of String)
            if let num: Int = Int(element){ //Try to convert String to integer
                numbers.append(num) //If successful, add element to array of numbers
            } else {
                operators.append(element)//else, add element to array of operators
            }
        }

        //Review given arguments and handle errors
        errorHandling(array: operators)
    
        //Do multiplication, division and modulo first
        //Go through all given operators and look for operators like [* / %]
        var currIndex: Int = 0 //A pointer used to retrieve operator and numbers used for operation
        while currIndex < operators.count{
            let op: String = operators[currIndex]
            if firstActions.contains(op){
                //Store two numbers used for current operation
                let firstNum: Int = numbers[currIndex]
                let secondNum: Int = numbers[currIndex+1]
                var newNum: Int //Store result of operation
                //Run function depending on given operator
                newNum = operation(no1: firstNum, no2: secondNum, op: op)
                //Put the result of the operation inside numbers array
                //Remove numbers and operator from two arrays, to store only remaining numbers and operators to process
                numbers[currIndex] = newNum
                numbers.remove(at: currIndex+1)
                operators.remove(at: currIndex)
            } else {
                //Go to next operator
                currIndex += 1
            }
        }

        //Assign result to fist number of the array with remaining numbers
        result = numbers[0]
        
        //If after finishing first actions [x,/,%] there are still operators left, they must be part of second action [+,-].
        //Evaluate remaining operations
        if operators.count != 0{
            for i: Int in 0..<operators.count{
                result = operation(no1: result, no2: numbers[i+1], op: operators[i])
            }
        }
        return(String(result))
    }
}
