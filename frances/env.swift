//
//  env.swift
//  frances
//
//  Created by Gerome Bochmann on 3/13/23.
//

import Foundation

typealias ArithmeticFn = ([Node]) -> Node

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
