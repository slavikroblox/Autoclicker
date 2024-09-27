//
//  ControlsView.swift
//  Autoclicker
//
//  Created by Vyacheslav on 9/24/24.
//

import SwiftUI

struct ControlsView: View {
    @EnvironmentObject var controls: Controls
    
    @State public var startButtonText : String = "F6"
    @State public var stopButtonText : String = "F6"
    @State private var startButtonTextPickerID = 0
    @State private var stopButtonTextPickerID = 1
    
    var body: some View {
        VStack {
            HStack {
                Picker(selection: $startButtonText, label: Text("Start: ")) {
                    
                    // F's
                    Text("F1").tag("F1")
                    Text("F2").tag("F2")
                    Text("F3").tag("F3")
                    Text("F4").tag("F4")
                    Text("F5").tag("F5")
                    Text("F6").tag("F6")
                    Text("F7").tag("F7")
                    Text("F8").tag("F8")
                    Text("F9").tag("F9")
                    Text("F10").tag("F10")
                    Text("F11").tag("F11")
                    Text("F12").tag("F12")
                    
                    // Other
                    Text("Insert").tag("ins")
                    Text("Command ⌘").tag("⌘")
                    Text("Option ⌥").tag("⌥")
                    Text("Shift ⇧").tag("⇧")
                    Text("Control ⌃").tag("⌃")
                    Text("Enter").tag("Enter")
                    Text("Delete").tag("del")
                    Text("Backspace").tag("back")
                    Text("Tab").tag("tab")
                    Text("Fn").tag("fn")
                    
                } .frame(width: 100) .id(startButtonTextPickerID)
            }
                
            HStack {
                Picker(selection: $stopButtonText, label: Text("Stop: ")) {
                    
                    // F's
                    Text("F1").tag("F1")
                    Text("F2").tag("F2")
                    Text("F3").tag("F3")
                    Text("F4").tag("F4")
                    Text("F5").tag("F5")
                    Text("F6").tag("F6")
                    Text("F7").tag("F7")
                    Text("F8").tag("F8")
                    Text("F9").tag("F9")
                    Text("F10").tag("F10")
                    Text("F11").tag("F11")
                    Text("F12").tag("F12")
                    
                    // Other
                    Text("Insert").tag("ins")
                    Text("Command ⌘").tag("⌘")
                    Text("Option ⌥").tag("⌥")
                    Text("Shift ⇧").tag("⇧")
                    Text("Control ⌃").tag("⌃")
                    Text("Enter").tag("Enter")
                    Text("Delete").tag("del")
                    Text("Backspace").tag("back")
                    Text("Tab").tag("tab")
                    Text("Fn").tag("fn")
                    
                } .frame(width: 100) .id(stopButtonTextPickerID)
            }
        }
        .padding()
    }
}
    
#Preview {
    ControlsView().environmentObject(Controls())
}
