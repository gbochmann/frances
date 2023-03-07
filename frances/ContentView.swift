//
//  ContentView.swift
//  macro-ios
//
//  Created by Gerome Bochmann on 3/6/23.
//

import SwiftUI

struct ContentView: View {
    @State var input = "Enter text"
    @State var output = "Output"
    
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
                
                Button("Run", action: runExpression)
                    .buttonStyle(.borderedProminent)
                    .tint(.primary)
                
                
            }.frame(maxWidth: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }.padding(10)
    }
    
    func runExpression() -> Void {
        print("running expression")
        
        do {
            output = try read(tokenize(input)).inspect()
        } catch ReadError.invalidExpression(let message) {
            print("Error occurred: \(message)")
        } catch {
            print("Unexpected Error: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
