//
//  eval.swift
//  frances
//
//  Created by Gerome Bochmann on 3/13/23.
//

import Foundation

enum EvaluationError: Error {
    case NotFound(String)
    case InvalidArguments(String)
}

func eval(_ node: Node, env: Env) throws -> Node {
    guard case let .List(unevaluated) = node else {
        return try evalAST(node: node, env: env)
    }

    if unevaluated.isEmpty {
        return node
    }
       
    switch unevaluated.first {
    case .Symbol("def"):
        guard unevaluated.count == 3 else { throw EvaluationError.InvalidArguments("Invalid number of arguments for 'def'")}
        guard case let .Symbol(name) = unevaluated[1] else {
            throw EvaluationError.InvalidArguments("Invalid symbol name in second argument")
        }
        
        let result = try eval(unevaluated[2], env: env)
        env.set(name, value: result)
        return result
        
    case .Symbol("let"):
        let body = unevaluated[2]
        
        guard unevaluated.count == 3 else { throw EvaluationError.InvalidArguments("Invalid number of args for let*")}
        guard case var .List(bindings) = unevaluated[1] else { throw EvaluationError.InvalidArguments("Invalid bindings for let*")}
        guard bindings.count % 2 == 0 else { throw EvaluationError.InvalidArguments("Bindings must have even number of elements.")}
        
        let localEnv = Env(parent: env, table: nil)
        repeat {
            let binding: [Node] = Array(bindings.prefix(2))
            bindings.removeFirst(2)
            let value = binding[1]
            guard case let .Symbol(name) = binding[0] else { throw EvaluationError.InvalidArguments("Expected symbold but found something else.")}
            
            try localEnv.set(name, value: evalAST(node: value, env: localEnv))
        } while !bindings.isEmpty
        
        return try evalAST(node: body, env: localEnv)
        
    
    default:
        guard case let .List(nodes) = try evalAST(node: node, env: rootEnv) else { fatalError() }
        guard case let .Function(function) = nodes.first else { throw EvaluationError.NotFound("Invalid function call \(String(describing: unevaluated.first))")}
            let args = Array(nodes.dropFirst())
            
            let resultingNode: Node = apply(fn: function, args: args)
            return resultingNode
    }

}

func evalAST(node: Node, env: Env) throws -> Node {
    switch node {
    case .Symbol(let name):
        return try env.get(name)
        
    case .List(let elements):
        return try .List(elements.map({ el in try eval(el, env: env)}))
        
    default:
        return node
    }
}
