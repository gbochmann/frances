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

func list(nodes: [Node]) -> Node {
    return .List(nodes)
}

func listQuestion(nodes: [Node]) -> Node {
    switch nodes.first {
    case .List:
        return Node.Boolean(true)
    default:
        return Node.Boolean(false)
    }
}

func emptyQuestion(nodes: [Node]) throws -> Node {
    guard case let .List(elements) = nodes.first else {
        throw EvaluationError.InvalidArguments("empty? expects a list as argument")
    }
    
    return Node.Boolean(elements.count > 0)
}

let ns: [String:Node] = [
    "+": .Function(calc(fn: add)),
    "-": .Function(calc(fn: subtract)),
    "*": .Function(calc(fn: multiply)),
    "/": .Function(calc(fn: divide)),
    "prn": .Function(prn),
    "list": .Function(list),
    "list?": .Function(listQuestion),
    "empty?": .Function(emptyQuestion)
]
