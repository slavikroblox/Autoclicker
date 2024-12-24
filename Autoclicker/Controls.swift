//
//  Controls.swift
//  Autoclicker
//
//  Created by Vyacheslav on 9/24/24.
//

import Foundation
import SwiftUI
import Combine

class Controls: ObservableObject {    
    @Published var startButtonText : String = "F6"
    @Published var stopButtonText : String = "F6"
    @Published var keyCodes: [String: UInt16] = [
        "F1": 122,
        "F2": 120,
        "F3": 99,
        "F4": 118,
        "F5": 96,
        "F6": 97,
        "F7": 98,
        "F8": 100,
        "F9": 101,
        "F10": 109,
        "F11": 103,
        "F12": 111
    ]
}
