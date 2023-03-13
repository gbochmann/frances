//
//  printer.swift
//  frances
//
//  Created by Gerome Bochmann on 3/13/23.
//

import Foundation

func printString(node: ASTNode) -> String {
    switch node {
    case is ASTSymbol:
        return (node as! ASTSymbol).name
    case is ASTNumber:
        return String((node as! ASTNumber).value)
    case is ASTList:
        let list = node as! ASTList
        let result = list.elements.map(printString)
        
        return "(\(result.joined(separator: " ")))"
    default:
        return "unknown symbol"
    }
}
