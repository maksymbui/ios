//
//  Calculator.swift
//  calc
//
//  Created by Jacktator on 31/3/20.
//  Copyright © 2020 UTS. All rights reserved.
//

import Foundation

class Calculator {

    //Initialize result where we store final evaluation of all operations
    var result: Int = 0
    
    //Create two separate arrays with valid operators to manage priority
    let firstActions: [String] = ["x","/","%"]
    let secondActions: [String] = ["+","-"]

    //Function for addition
    func add(no1: Int, no2: Int) -> Int {
        return no1 + no2;
    }

    //Function for substraction
    func sub(no1: Int, no2: Int) -> Int{
        return no1 - no2    
    }

    //Function for division
    func div(no1: Int, no2: Int) -> Int{
        return no1 / no2;
    }

    //Function for multiplication
    func mult(no1: Int, no2: Int) -> Int{
        return no1 * no2
    }
    
    //Function for modulo
    func mod(no1: Int, no2: Int) -> Int{
        return no1 % no2
    }

    //Function for error handling
    func errorHandling(array: [String]) throws{
        //If no operators are included in the arguments return fatal error
        if array.count == 0{
            throw fatalError()
        }

        //If invalid operators are included in the arguments return fatal error
        for op in array{
            if !firstActions.contains(op) && !secondActions.contains(op){
                throw fatalError()
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
        for element in newArray{
            //Loop through each given argument (Array of String)
            if let num = Int(element){ //Try to convert String to integer
                numbers.append(num) //If successful, add element to array of numbers
            } else {
                operators.append(element)//else, add element to array of operators
            }
        }

        //Review given arguments and handle errors
        try errorHandling(array: operators)
    
        //Do multiplication, division and modulo first
        //Go through all given operators and look for operators like [* / %]
        var currIndex: Int = 0
        while currIndex < operators.count{
            let op = operators[currIndex]
            if firstActions.contains(op){
                let firstNum = numbers[currIndex]
                let secondNum = numbers[currIndex+1]
                var newNum: Int = 0 //Store result of operation
                //Run function depending on given operator
                switch op{
                case "x":
                    newNum = mult(no1:firstNum,no2: secondNum)
                case "/":
                    newNum = div(no1: firstNum, no2: secondNum)
                case "%":
                    newNum = mod(no1: firstNum, no2: secondNum)
                default:
                    throw fatalError()//If operator is invalid, throw error
                }
                //Put the result of the operation inside our numbers array
                //Remove numbers and operator from arrays, to store only remaining numbers and operators to process
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
            for i in 0..<operators.count{
                switch operators[i]{
                case "+":
                    result = add(no1: result, no2: numbers[i+1])
                case "-":
                    result = sub(no1: result, no2: numbers[i+1])
                default:
                    throw fatalError()
                }
            }
        }
        return(String(result))
    }
}
