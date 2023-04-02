//
//  repl.swift
//  frances
//
//  Created by Gerome Bochmann on 3/25/23.
//

import Foundation
import SwiftUI

struct REPLView: View {
    @State private var input: String = ""
    @State private var output: [String] = []
    
    var body: some View {
        VStack {
            resultsView
            inputSection
        }.font(Font.system(.body, design: .monospaced))
    }
    
    private func runCode() {
        let evaluationResult: String
        do {
            evaluationResult = try prn(eval(read(input), env: rootEnv))
        } catch ReaderError.InvalidSyntax(let message) {
            evaluationResult = "Reader Error: \(message)"
        } catch EvaluationError.NotFound(let message) {
            evaluationResult = "Evaluation Error: \(message)"
        } catch EnvironmentError.NotFound(let message) {
            evaluationResult = "Environment Error: \(message)"
        } catch {
            evaluationResult = error.localizedDescription
        }
        
        output.append(input)
        output.append(evaluationResult)
        input = ""
    }
    
    private var resultsView: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Spacer()
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(output.indices, id: \.self) { index in
                            Text(output[index])
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                    }
                }.padding()
                    .frame(minHeight: geometry.size.height)
            }.frame(minWidth: geometry.size.width)
        }
    }
    
    private var inputSection: some View {
        HStack {
            TextField("Type away!", text: $input)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.leading)
                .autocapitalization(.none)
            
            Button(action: {
                runCode()
            }) {
                Text("Run")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.trailing)
            }
        }.padding(.bottom)
    }
}
