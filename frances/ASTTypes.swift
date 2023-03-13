//
//  ASTTypes.swift
//  frances
//
//  Created by Gerome Bochmann on 3/13/23.
//

import Foundation

protocol ASTNode {}

class ASTNumber: ASTNode {
    let valueAsString: String
    
    init(token: String) {
        self.valueAsString = token
    }
}

class ASTSymbol: ASTNode {
    let name: String
    
    init(token name: String) {
        self.name = name
    }
}

class ASTList: ASTNode {
    let elements: [ASTNode]
    
    init(elements: [ASTNode]) {
        self.elements = elements
    }
}

class UnknownAtom: ASTNode {
    let token: String
    
    init(token: String) {
        self.token = token
    }
}
