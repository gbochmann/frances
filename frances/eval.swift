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

func evalAST(node: ASTNode, env: [String:Any]) throws -> Any {
    switch node {
    case is ASTSymbol:
        let symbol = node as! ASTSymbol
        guard let symbolValue = env[symbol.value as! String] else {
            throw EvaluationError.NotFound("Could not find \(symbol.value as! String) in environment.")
        }
        return symbolValue
        
    case is ASTList:
        let list = node as! ASTList
        return try (list.value as! [ASTNode]).map({ el in try evalAST(node: el, env: replEnv)})
        
    default:
        return node.value
    }
    
}
