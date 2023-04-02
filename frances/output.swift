//
//  output.swift
//  frances
//
//  Created by Gerome Bochmann on 3/25/23.
//

import Foundation
import Combine

class REPLOutput: ObservableObject {
    @Published var output: [String] = []
    
    func appendOutput(_ value: String) {
        DispatchQueue.main.async {
            self.output.append(value)
        }
    }
}
