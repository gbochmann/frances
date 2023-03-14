//
//  printer.swift
//  frances
//
//  Created by Gerome Bochmann on 3/13/23.
//

import Foundation

func printString(node: Node) -> String {
    switch node {
    case .Symbol(let name):
        return name
    case .Number(let num):
        return String(num)
    case .List(let list):
        let result = list.map(printString)
        
        return "(\(result.joined(separator: " ")))"
    default:
        return "unknown symbol"
    }
}
