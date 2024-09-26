//
//  ControlsView.swift
//  Autoclicker
//
//  Created by Vyacheslav on 9/24/24.
//

import SwiftUI

struct ControlsView: View {
    @EnvironmentObject var controls: Controls
    
    @State private var startButtonText = "F6"
    @State private var stopButtonText = "F6"
    
    @FocusState private var focused: Bool
    
    var body: some View {
        VStack {
            HStack {
                Picker(selection: $startButtonText, label: Text("Start: ")) {
                    
                    // F's
                    Text("F1")
                    Text("F2")
                    Text("F3")
                    Text("F4")
                    Text("F5")
                    Text("F6")
                    Text("F7")
                    Text("F8")
                    Text("F9")
                    Text("F10")
                    Text("F11")
                    Text("F12")
                    
                    // Other
                    Text("Insert")
                    Text("Command ⌘")
                    Text("Option ⌥")
                    Text("Shift ⇧")
                    Text("Control ⌃")
                    
                    // Custom
                    Text("Custom")
                    
                } .frame(width: 100)
            }
                
            HStack {
                Picker(selection: $startButtonText, label: Text("Stop: ")) {
                    
                    // F's
                    Text("F1")
                    Text("F2")
                    Text("F3")
                    Text("F4")
                    Text("F5")
                    Text("F6")
                    Text("F7")
                    Text("F8")
                    Text("F9")
                    Text("F10")
                    Text("F11")
                    Text("F12")
                    
                    // Other
                    Text("Insert")
                    Text("Command ⌘")
                    Text("Option ⌥")
                    Text("Shift ⇧")
                    Text("Control ⌃")
                    
                    // Custom
                    Text("Custom")
                    
                } .frame(width: 100)
            }
        }
        .padding()
    }
}
    
#Preview {
    ControlsView().environmentObject(Controls())
}
