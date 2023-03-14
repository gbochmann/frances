//
//  env.swift
//  frances
//
//  Created by Gerome Bochmann on 3/13/23.
//

import Foundation

typealias ArithmeticFn = ([Node]) -> Node

func calc(fn: (Int, Int) -> Int) -> ArithmeticFn {
    return { (args: [Node]) in
        guard case let .Number(first) = args.first else { return .Number(0) }
        let rest = args.dropFirst()
        let result = rest
            .map({ x in if case let .Number(num) = x {
                return num
            } else { return 0 }})
            .reduce(first, { x, y in x + y })
        
        return .Number(result)
    }
}

let add = calc(fn: { x, y in x + y})
let subtract = calc(fn: { a, b in a - b })
let multiply = calc(fn: { a, b in a * b })
let divide = calc(fn: { a, b in Int(a/b) })


let replEnv: [String: ArithmeticFn] = [
    "+": add,
    "-": subtract,
    "*": multiply,
    "/": divide
]
