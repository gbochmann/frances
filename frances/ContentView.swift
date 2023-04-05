//
//  ContentView.swift
//  macro-ios
//
//  Created by Gerome Bochmann on 3/6/23.
//

import SwiftUI

func apply<T, V>(fn: @escaping ([T]) throws -> V, args: [T]) rethrows -> V {
    return try fn(args)
}

func read(_ input: String) throws -> Node {
    return try readString(input)
}

func prn(_ input: Node) -> String {
    return prStr(node: input)
}



struct ContentView: View {
    @State var input = ""
    
    var body: some View {
        NavigationView {
            REPLView()
                .navigationTitle("Frances REPL")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
