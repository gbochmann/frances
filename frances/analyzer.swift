//
//  analyzer.swift
//  frances
//
//  Created by Gerome Bochmann on 3/8/23.
//

import Foundation

enum FType {
    case Number
}

struct ASTNode {
    let value: String
    let kind: FType
}

func analyze(forms: [String]) -> ASTNode {
    return ASTNode(value: "", kind: FType.Number)
}
