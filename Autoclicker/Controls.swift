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
}
