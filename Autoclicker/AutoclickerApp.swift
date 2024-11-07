//
//  AutoclickerApp.swift
//  Autoclicker
//
//  Created by Vyacheslav on 15.09.2024.
//

import SwiftUI

@main
struct AutoclickerApp: App {
    @StateObject private var controls = Controls()
    
    var body: some Scene {
        WindowGroup {
            TabMenu()
        }
    }
}
