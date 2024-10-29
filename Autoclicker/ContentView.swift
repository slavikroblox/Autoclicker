//
//  ContentView.swift
//  Autoclicker
//
//  Created by Vyacheslav on 15.09.2024.
//

import SwiftUI
import AppKit

struct ContentView: View {
    @EnvironmentObject var controls: Controls
    
    @State private var autoClick: Autoclick?
    
    @FocusState private var isFocused: Bool
    
    init() {
    }
    
    @State public var running : Bool = false
    
    @State public var cps : Double = 1.0 {
        didSet {
            if cps < 1.0 {
                cps = 1.0
            }
        }
    }
    
    @State public var repeatTimes : Int = 0
    @State public var repeatType = "times"
    
    @State public var hours : Int = 0
    @State public var minutes : Int = 0
    @State public var seconds : Int = 0
    
    @State public var positionType = "manual"
    @State public var xPosition : Int = 0
    @State public var yPosition : Int = 0
    
    @State public var mouseButton = "left"
    
    @State public var timerBeforeStart = 0.0
    
    @State public var startButtonText = "Start"
    
    @State private var keyHandler: KeyHandler?
    
    var body: some View {
        VStack {
            HStack {
                Text("Hours")
                TextField("0", value: $hours, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 50)
                    .disabled(repeatType != "until_timer_ends")
                    .focused($isFocused)
                    .onSubmit { isFocused = false }
                        
                Text("Minutes")
                TextField("0", value: $minutes, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 50)
                    .disabled(repeatType != "until_timer_ends")
                    .focused($isFocused)
                    .onSubmit { isFocused = false }
                        
                Text("Seconds")
                TextField("0", value: $seconds, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 50)
                    .disabled(repeatType != "until_timer_ends")
                    .focused($isFocused)
                    .onSubmit { isFocused = false }
            }
            
            HStack {
                Text("CPS")
                TextField("0", value: $cps, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 50)
                    .focused($isFocused)
                    .onSubmit { isFocused = false }
            }
            
            Picker(selection: $mouseButton, label: Text("Mouse button:")) {
                Text("Left").tag("left")
                Text("Middle").tag("middle")
                Text("Right").tag("right")
            } .frame(width: 175)
            
            HStack {
                Picker(selection: $repeatType, label: Text("Repeat:")) {
                    HStack {
                        Text("Times")
                        TextField("0", value: $repeatTimes, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 50)
                            .disabled(repeatType != "times")
                            .focused($isFocused)
                            .onSubmit { isFocused = false }
                    } .tag("times")
                    Text("Until stop").tag("until_stop")
                    Text("Until timer ends").tag("until_timer_ends")
                } .pickerStyle(RadioGroupPickerStyle())
            }
                
            HStack {
                Picker(selection: $positionType, label: Text("Position: ")) {
                    HStack {
                        Text("X:")
                        TextField("0", value: $xPosition, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 50)
                            .disabled(positionType != "manual")
                            .focused($isFocused)
                            .onSubmit { isFocused = false }
                        Text("Y:")
                        TextField("0", value: $yPosition, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 50)
                            .disabled(positionType != "manual")
                            .focused($isFocused)
                            .onSubmit { isFocused = false }
                    } .tag("manual")
                    Text("Mouse position when starting").tag("mouse_pos_current")
                    Text("Always follow mouse").tag("mouse_follow")
                } .pickerStyle(RadioGroupPickerStyle())
            }
            
            HStack {
                Picker(selection: $timerBeforeStart, label: Text("Timer before start: ")) {
                    Text("Off").tag(0.0)
                    Text("3s").tag(3.0)
                    Text("5s").tag(5.0)
                    Text("10s").tag(10.0)
                }.frame(width: 200)
            }
            
            HStack {
                
                Button(action: {running = true; print("Starting"); autoClick?.startAutoClick()}, label: {
                    Text(startButtonText)
                        .frame(width: 150)
                })
                .disabled(running)
                
                Button(action: {running = false}, label: {
                    Text("Stop (\(controls.stopButtonText))")
                        .frame(width: 150)
                })
                .disabled(!running)
                .onAppear {
                    autoClick = Autoclick(contentView: self)
                }
            }
        }
        .padding()
        .onAppear() {
            let autoclick = Autoclick(contentView: self)
            let controls = Controls()
            keyHandler = KeyHandler(autoclick: autoclick, contentView: self, controls: controls)
            
            startButtonText = "Start (\(controls.startButtonText))"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isFocused = false
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Controls())
}
