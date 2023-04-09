//
//  reader.swift
//  frances
//
//  Created by Gerome Bochmann on 3/11/23.
//

import Foundation
import RegexBuilder

enum ReaderError: Error {
    case InvalidSyntax(String)
    case UnexpectedEnd
}

class Reader {
    let tokens: [String]
    var position = 0
    
    var isExhausted: Bool {
        get {
            return !(position < tokens.count - 1)
        }
    }
    
    init(tokens: [String], position: Int = 0) {
        self.tokens = tokens.filter { t in t.count > 0 }
        self.position = position
    }
    
    func next() throws -> String {
        
        let newPosition = position + 1
        guard tokens.count - 1 >= newPosition else {
            throw ReaderError.UnexpectedEnd
        }
        
        position = newPosition
        return tokens[position]

    }
    
    func peek() -> String {
        return tokens[position]
    }
}

func tokenize(_ input: String) throws -> [String] {
    let pattern = "[\\s,]*(~@|[\\[\\]{}()'`~^@]|\"(?:\\\\.|[^\\\\\"])*\"?|;.*|[^\\s\\[\\]{}('\"`,;)]*)"
    var result: [String] = []

    let regex = try NSRegularExpression(pattern: pattern, options: [])
    let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))

    for match in matches {
        if let range = Range(match.range, in: input) {
            let matchString = input[range]
            result.append(String(matchString))
        }
    }
    
    return result.map { s in s.trimmingCharacters(in: .whitespacesAndNewlines ) }
}

func readAtom(_ r: Reader) throws -> Node {
    let token = r.peek()
    if let asInt = Int(token) {
        return Node.Number(asInt)
    }
    
    if let asBoolean = Bool(token) {
        return Node.Boolean(asBoolean)
    }
    
    if token == "nil" {
        return Node.Nil
    }

    if (token.matches(of: /[a-zA-Z0-9+-\/_><=*]+/)).count > 0 {
        return Node.Symbol(token)
    }
    
    throw ReaderError.InvalidSyntax("Unexpected token: \(token)")
}

func readList(_ r: Reader) throws -> Node {
    var token = try r.next()
    var list: [Node] = []
    
    while !r.isExhausted && token != ")" {
        
        if token == "(" {
            list.append(try readList(r))
        } else {
            list.append( try readForm(r))
        }
        
        token = try r.next()
    }
    
    if r.isExhausted && token != ")" {
        throw ReaderError.InvalidSyntax("Expected ')'")
    }
    
    return Node.List(list)
}

func readForm(_ r: Reader) throws -> Node {
    let token = r.peek()
    
    if token == "(" {
        return try readList(r)
    } else {
        return try readAtom(r)
    }
}

func readString(_ input: String) throws -> Node {
    let reader = Reader(tokens: try tokenize(input))
    return try readForm(reader)
}
