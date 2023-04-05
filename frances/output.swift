//
//  output.swift
//  frances
//
//  Created by Gerome Bochmann on 3/25/23.
//

import Foundation
import Combine

class REPLOutput: ObservableObject {
    @Published var history: [String] = []
    
    func append(_ value: String) {
        DispatchQueue.main.async {
            self.history.append(value)
        }
    }
}
