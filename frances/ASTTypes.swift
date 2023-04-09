//
//  ASTTypes.swift
//  frances
//
//  Created by Gerome Bochmann on 3/13/23.
//

import Foundation

enum Node {   
    case Number(Int)
    case Symbol(String)
    indirect case List([Node])
    case Function(FFunction)
    case Nil
    case Boolean(Bool)
    
}
