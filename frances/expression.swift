//
//  expression.swift
//  macro-ios
//
//  Created by Gerome Bochmann on 3/6/23.
//

import Foundation

struct Expression {
    enum Operator: String {
        case addition = "+",
             subtraction = "-",
             product = "*",
             division = "/",
             empty = ""
    }
    
    enum Operand {
        case Expression(Expression)
        case Value(Value)
        
        func inspect() -> String {
            switch self {
            case .Expression(let expr):
                return expr.inspect()
            case .Value(let value):
                return value.inspect()
            }
            
        }
    }
    
    enum Value {
        case Number(Int)
        
        func inspect() -> String {
            switch self {
                case .Number(let n):
                    return "Number:" + String(n)
                }
        }
    }
    
    var op: Operator?
    var operands: [Operand]
    
    init(op: Operator?, operands: [Operand]) {
        if let operatr = op {
            self.op = operatr
        }
        self.operands = operands
    }
    
    func inspect() -> String {
        var operatorNode = ""
        
        if let operatr = self.op {
            operatorNode = "operator" + operatr.rawValue
        }
        
        return operatorNode + "|"
        + self.operands
            .map({ (o: Operand) in o.inspect() })
            .joined(separator: "|")
    }
}