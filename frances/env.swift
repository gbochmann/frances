//
//  env.swift
//  frances
//
//  Created by Gerome Bochmann on 3/13/23.
//

import Foundation

var replEnv: [String:Any] = [
    "+": { (a: Int, b: Int) -> Int in a + b},
    "-": { (a: Int, b: Int) -> Int in a - b},
    "*": { (a: Int, b: Int) -> Int in a * b},
    "/": { (a: Int, b: Int) -> Int in a / b}
]
