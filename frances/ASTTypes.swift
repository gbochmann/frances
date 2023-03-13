//
//  ASTTypes.swift
//  frances
//
//  Created by Gerome Bochmann on 3/13/23.
//

import Foundation

protocol ASTNode {
    var value: Any { get set }
}

class ASTNumber: ASTNode {
    var value: Any
    let valueAsString: String
    
    init(token: String) {
        self.valueAsString = token
        self.value = Int(token)!
    }
}

class ASTSymbol: ASTNode {
    var value: Any
    
    init(token name: String) {
        self.value = name
    }
}

class ASTList: ASTNode {
    var value: Any
    
    init(elements: [ASTNode]) {
        self.value = elements
    }
}
