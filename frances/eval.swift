//
//  eval.swift
//  frances
//
//  Created by Gerome Bochmann on 3/13/23.
//

import Foundation

enum EvaluationError: Error {
    case NotFound(String)
}

func eval(_ input: Node, env: [String:Any]) throws -> Node {
    
    switch input {
    case .List(let elements):
        
        if elements.count == 0 {
            return input
        } else {
            let sExpression = try evalAST(node: input, env: replEnv)
            
            if case .List(let array) = sExpression {
                guard case let .Function(function) = array.first else { throw EvaluationError.NotFound("Invalid function call \(String(describing: elements.first))")}
                let args = Array(array.dropFirst())
                
                let resultingNode: Node = apply(fn: function, args: args)
                return resultingNode
            }
        }
    default:
        return try evalAST(node: input, env: replEnv)
    }
    
    return input
}

func evalAST(node: Node, env: [String:ArithmeticFn]) throws -> Node {
    switch node {
    case .Symbol(let name):
        guard let symbolValue = env[name] else {
            throw EvaluationError.NotFound("Could not find \(name) in environment.")
        }
        
        return .Function(symbolValue)
        
    case .List(let elements):
        return try .List(elements.map({ el in try eval(el, env: replEnv)}))
        
    default:
        return node
    }
}
