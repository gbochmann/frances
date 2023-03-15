//
//  env.swift
//  frances
//
//  Created by Gerome Bochmann on 3/13/23.
//

import Foundation

typealias ArithmeticFn = ([Node]) -> Node

enum EnvironmentError: Error {
    case NotFound(String)
}

class Env {
    let outer: Env?
    var table: [String:Node]
    
    init(outer: Env?) {
        self.outer = outer
        self.table = [:]
    }
    
    func set(_ key: String, value: Node) {
        self.table[key] = value
    }
    
    func get(_ key: String) throws -> Node {
        guard let env = find(key) else {
            throw EnvironmentError.NotFound("Could not locate \(key).")
        }
        
        return try env.get(key)
    }
    
    func find(_ key: String) -> Env? {
        if table[key] != nil {
            return self
        } else {
            return outer?.find(key)
        }
    }
}

func calc( fn: @escaping (Int, Int) -> Int) -> ArithmeticFn {
    func calcWrapper(args: [Node]) -> Node {
        guard case let .Number(first) = args.first else { return .Number(0) }
        let rest = args.dropFirst()
        let result = rest
            .map({ x in if case let .Number(num) = x {
                return num
            } else { return 0 }})
            .reduce(first, fn)
        
        return .Number(result)
    }
    
    return calcWrapper
}

func add(a: Int, b: Int) -> Int {
    return a + b
}

func subtract(a: Int, b: Int) -> Int {
    return a - b
}

func multiply(a: Int, b: Int) -> Int {
    return a * b
}

func divide(a: Int, b: Int) -> Int {
    return Int(a/b)
}


let replEnv: [String: ArithmeticFn] = [
    "+": calc(fn: add),
    "-": calc(fn: subtract),
    "*": calc(fn: multiply),
    "/": calc(fn: divide),
]
