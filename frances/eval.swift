//
//  eval.swift
//  frances
//
//  Created by Gerome Bochmann on 3/7/23.
//

import Foundation

enum EvalError {
    
}

func eval(_ expr: Expression) throws -> String {
    if expr.op == nil {
        return ""
    }
    return String(0)
}
