//
//  ASTTypes.swift
//  frances
//
//  Created by Gerome Bochmann on 3/13/23.
//

import Foundation

protocol ASTNode {
    var token: String { get set }
    var evaluated: EvaluationResult { get set }
    associatedtype EvaluationResult
}

class ASTNumber: ASTNode {
    var token: String
    var value: Int
    typealias EvaluationResult = Int?
    var evaluated: Int?
    
    init(token: String) {
        self.token = token
        self.value = Int(token)!
    }
}

class ASTSymbol: ASTNode {
    var name: String
    var token: String
    typealias EvaluationResult = ((Int, Int) -> Int)?
    var evaluated: ((Int, Int) -> Int)?
    
    init(token name: String) {
        self.token = name
        self.name = name
    }
}

class ASTList: ASTNode {
    var token: String
    var elements: [any ASTNode]
    typealias EvaluationResult = [Any]?
    var evaluated: [Any]?
    
    
    init(elements: [any ASTNode]) {
        self.token = String(elements.map({ t in t.token }).joined(separator: " "))
        self.elements = elements
    }
}

enum Node {
    case Number(Int)
    case Symbol(String)
    indirect case List([Node])
    case Atom(Any)
    case Function(ArithmeticFn)
}
