//
//  core.swift
//  frances
//
//  Created by Gerome Bochmann on 3/24/23.
//

import Foundation

let ns: [String:Node] = [
    "+": .Function(calc(fn: add)),
    "-": .Function(calc(fn: subtract)),
    "*": .Function(calc(fn: multiply)),
    "/": .Function(calc(fn: divide)),
]
