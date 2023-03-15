//
//  ContentView.swift
//  macro-ios
//
//  Created by Gerome Bochmann on 3/6/23.
//

import SwiftUI

func apply<T, V>(fn: ([T]) -> V, args: [T]) -> V {
    return fn(args)
}

func read(_ input: String) throws -> Node {
    return try readString(input)
}

func prn(_ input: Node) -> String {
    return printString(node: input)
}

struct ContentView: View {
    @State var input = ""
    @State var output = ""
    
    var body: some View {
        VStack {
            VStack {
                Text(output)
                    .monospaced(true)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
            HStack {
                VStack {
                    TextField("Type command", text:$input)
                        .monospaced(true)
                        .textFieldStyle(.roundedBorder)
                }
                
                Button("Run", action: rep)
                    .buttonStyle(.borderedProminent)
                    .tint(.primary)
                
                
            }.frame(maxWidth: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }.padding(10)
    }
    
    func rep() -> Void {
        do {
            output = try prn(eval(read(input), env: replEnv))
        } catch ReaderError.InvalidSyntax(let message) {
            output = message
        } catch EvaluationError.NotFound(let message) {
            output = message
        } catch {
            output = error.localizedDescription
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
