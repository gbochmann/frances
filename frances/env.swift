//
//  env.swift
//  frances
//
//  Created by Gerome Bochmann on 3/13/23.
//

import Foundation

enum EnvironmentError: Error {
    case NotFound(String)
}

class Env {
    let outer: Env?
    var table: [String:Node]
    
    init(parent outer: Env?, table: [String:Node]?) {
        self.outer = outer
        self.table = table ?? [:]
    }
    
    init(parent: Env, params: [String], args: [Node]) {
        self.outer = parent
        self.table = [:]
        
        for p in 0..<params.count {
            let param = params[p]
            let argument = args[p]
            
            table[param] = argument
        }
    }
    
    func set(_ key: String, value: Node) {
        self.table[key] = value
    }
    
    func get(_ key: String) throws -> Node {
        guard let env = find(key) else {
            throw EnvironmentError.NotFound("Could not locate \(key).")
        }
        
        // This is okay here because `find` already checked if it exists.
        return env.table[key]!
    }
    
    func find(_ key: String) -> Env? {
        if table[key] != nil {
            return self
        } else {
            return outer?.find(key)
        }
    }
}

func calc( fn: @escaping (Int, Int) -> Int) throws -> FFunction {
    func calcWrapper(args: [Node]) throws -> Node {
        guard case let .Number(first) = args.first else { return .Number(0) }
        let rest = args.dropFirst()
        let result = try rest.map({ x in
                                    guard case let .Number(num) = x else { throw EvaluationError.InvalidArguments("")}
                                    return num
                                })
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

do {
    let rootEnv: Env = Env(parent: nil, table: [
        "+": .Function(try calc(fn: add)),
        "-": .Function(try calc(fn: subtract)),
        "*": .Function(try calc(fn: multiply)),
        "/": .Function(try calc(fn: divide)),
    ])
} catch {
    fatalError()
}
