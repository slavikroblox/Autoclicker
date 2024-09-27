//
//  ContentView.swift
//  Autoclicker
//
//  Created by Vyacheslav on 15.09.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var controls: Controls
    
    @State private var autoClick: Autoclick?
    
    init() {
    }
    
    @State public var running : Bool = false
    
    @State private var cps : Int = 0
    @State private var repeatTimes : Int = 0
    @State private var repeatType = "times"
    @State private var xPosition = 0
    @State private var yPosition = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("CPS")
                TextField("0", value: $cps, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 50)
            }
                
            HStack {
                Picker(selection: $repeatType, label: Text("Repeat: ")) {
                    HStack {
                        Text("Times")
                        TextField("0", value: $repeatTimes, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 50)
                            .disabled(repeatType != "times")
                    } .tag("times")
                    Text("Until stop").tag("until_stop")
                    Text("Until timer ends").tag("until_timer_ends")
                } .pickerStyle(RadioGroupPickerStyle())
            }
            
            HStack {
                Text("Position: ")
                Text("X")
                TextField("0", value: $xPosition, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 50)
                Text("Y")
                TextField("0", value: $xPosition, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 50)
            }
            
            HStack {
                
                Button(action: {running = true; print("Starting"); autoClick?.startAutoClick()}, label: {
                    Text("Start (\(controls.startButtonText))")
                        .frame(width: 100)
                })
                .disabled(running)
                
                Button(action: {running = false}, label: {
                    Text("Stop (\(controls.stopButtonText))")
                        .frame(width: 100)
                })
                .disabled(!running)
                .onAppear {
                    autoClick = Autoclick(contentView: self)
                }
            }
        }
        .padding()
    }
    
}

#Preview {
    ContentView()
}
