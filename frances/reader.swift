//
//  reader.swift
//  macro-ios
//
//  Created by Gerome Bochmann on 3/6/23.
//

import Foundation

func tokenize(_ s: String) -> [String] {
    return s.replacingOccurrences(of: "(", with: "( ")
        .replacingOccurrences(of: ")", with: " )")
        .split(separator: " ")
        .map{ String($0) }
}

enum ReadError: Error {
    case invalidExpression(String)
}


func read(_ tokens: [String]) throws -> Expression {
    
    
    print("This works!")
    
    
    guard tokens.first == "(" else {
        throw ReadError.invalidExpression("Expected expression to start with paren.")
    }
    
    let remainingTokens = tokens.dropFirst()
    if (remainingTokens.first == nil) {
        return Expression(op: Expression.Operator.empty, operands: [])
    }
    guard let operatr = Expression.Operator(rawValue: remainingTokens.first!) else {
        throw ReadError.invalidExpression("First element must be an operator.")
    }
    
    var operands = remainingTokens.dropFirst()
    var operand = operands.first!
    var resultOperands: [Expression.Operand] = []
    
    while operands.count > 0 {
        if let number = Int(operand) {
            resultOperands.append(Expression.Operand.Value(Expression.Value.Number(number)))
            
            operand = operands.removeFirst()
            continue
        } else if operand == "(" {
            let closingIndex = operands.firstIndex(of: ")")
            guard let endIndex = closingIndex else {
                throw ReadError.invalidExpression("Could not find closing parens.")
            }

            let group = Array(operands[...endIndex])
            resultOperands.append(Expression.Operand.Expression(try read(group)))
            
            operands.removeFirst(endIndex + 1)
            operand = operands.first!
            continue
        }
    }
    
    print(operatr)
    print(operands)
    
    return Expression(op: operatr, operands: Array(resultOperands))
}
