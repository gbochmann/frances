//
//  core.swift
//  frances
//
//  Created by Gerome Bochmann on 3/24/23.
//

import Foundation

func prn(args: [Node]) -> Node {
    if (!args.isEmpty) {
        for a in args {
            replOut.append(prStr(node: a))
        }
    }
    return Node.Nil
}

let ns: [String:Node] = [
    "+": .Function(calc(fn: add)),
    "-": .Function(calc(fn: subtract)),
    "*": .Function(calc(fn: multiply)),
    "/": .Function(calc(fn: divide)),
    "prn": .Function(prn)
]
