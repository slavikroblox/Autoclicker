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
    
    @FocusState public var isFocused: Bool
    
    init() {
    }
    
    @State public var running : Bool = false
    
    @State public var cps : Double = UserDefaults.standard.double(forKey: "cps")
    
    @State public var repeatTimes : Int = UserDefaults.standard.integer(forKey: "repeatTimes")
    @State public var repeatType = UserDefaults.standard.string(forKey: "repeatType") ?? "times"
    
    @State public var hours : Int = UserDefaults.standard.integer(forKey: "hours") != 0 ? UserDefaults.standard.integer(forKey: "hours") : 0
    @State public var minutes : Int = UserDefaults.standard.integer(forKey: "minutes") != 0 ? UserDefaults.standard.integer(forKey: "minutes") : 0
    @State public var seconds : Int = UserDefaults.standard.integer(forKey: "seconds") != 0 ? UserDefaults.standard.integer(forKey: "seconds") : 0
    
    @State public var positionType = UserDefaults.standard.string(forKey: "positionType") ?? "manual"
    @State public var xPosition : Int = UserDefaults.standard.integer(forKey: "xPosition") != 0 ? UserDefaults.standard.integer(forKey: "xPosition") : 0
    @State public var yPosition : Int = UserDefaults.standard.integer(forKey: "yPositon") != 0 ? UserDefaults.standard.integer(forKey: "yPositon") : 0
    
    @State public var mouseButton = UserDefaults.standard.string(forKey: "mouseButton") ?? "left"
    
    @State public var timerBeforeStart : Double = 0.0
    
    @State public var startButtonText = "Start"
    
    @State private var keyHandler: KeyHandler?
    
    @State private var cpsErrorText = ""
    
    // UI view
    var body: some View {
        VStack {
            Section {
                timer
            }
            
            HStack {
                Text("CPS")
                TextField("0", value: $cps, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 60)
                    .focused($isFocused)
                    .onSubmit { isFocused = false }
            }
            
            Picker(selection: $mouseButton, label: Text("Mouse button:")) {
                Text("Left").tag("left")
                Text("Middle").tag("middle")
                Text("Right").tag("right")
            } .frame(width: 175)
            
            Section {
                repeatSelect
            }
                
            Section {
                positionSelect
            }
            
            Section {
                timerBeforeStartView
            }
            
            Section {
                startAndStopButtons
            }
            
            Text(cpsErrorText)
        }
        .padding()
        .onAppear {
            let autoclick = Autoclick(contentView: self)
            let controls = Controls()
            keyHandler = KeyHandler(autoclick: autoclick, contentView: self, controls: Controls())
            
            startButtonText = "Start (\(controls.startButtonText))"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isFocused = false
            }
        }
        .onChange(of: cps) { UserDefaults.standard.set(cps, forKey: "cps") }
        .onChange(of: repeatTimes) { UserDefaults.standard.set(repeatTimes, forKey: "repeatTimes") }
        .onChange(of: repeatType) { UserDefaults.standard.set(repeatType, forKey: "repeatType") }
        .onChange(of: mouseButton) { UserDefaults.standard.set(mouseButton, forKey: "mouseButton") }
        .onChange(of: hours) { UserDefaults.standard.set(hours, forKey: "hours") }
        .onChange(of: minutes) { UserDefaults.standard.set(minutes, forKey: "minutes") }
        .onChange(of: seconds) { UserDefaults.standard.set(seconds, forKey: "seconds") }
        .onChange(of: positionType) { UserDefaults.standard.set(positionType, forKey: "positionType") }
        .onChange(of: xPosition) { UserDefaults.standard.set(xPosition, forKey: "xPosition") }
        .onChange(of: yPosition) { UserDefaults.standard.set(yPosition, forKey: "yPosition") }
    }
    
    @ViewBuilder
    
    // Repeat selecter UI
    var repeatSelect: some View {
        HStack {
            HStack {
                Picker(selection: $repeatType, label: Text("Repeat:")) {
                    HStack {
                        Text("Times")
                        TextField("0", value: $repeatTimes, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 60)
                            .disabled(repeatType != "times")
                            .focused($isFocused)
                            .onSubmit { isFocused = false }
                    } .tag("times")
                    Text("Until stop").tag("until_stop")
                    Text("Until timer ends").tag("until_timer_ends")
                } .pickerStyle(RadioGroupPickerStyle())
            }
        }
    }
    
    @ViewBuilder
    
    // Click position selecter UI
    var positionSelect: some View {
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
                Text("Always follow mouse").tag("mouse_follow")
            } .pickerStyle(RadioGroupPickerStyle())
        }
    }
    
    @ViewBuilder
    
    // Timer UI
    var timer: some View {
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
    }
    
    @ViewBuilder
    
    // Timer before start UI
    var timerBeforeStartView: some View {
        HStack {
            Picker(selection: $timerBeforeStart, label: Text("Timer before start: ")) {
                Text("Off").tag(0.0)
                Text("3s").tag(3.0)
                Text("5s").tag(5.0)
                Text("10s").tag(10.0)
            }.frame(width: 200)
        }
    }
    
    @ViewBuilder
    
    // UI for start and stop buttons
    var startAndStopButtons: some View {
        HStack {
            Button(action: {running = true; print("Starting"); cps <= 0 ? cpsErrorText = "CPS cannot be zero or negative." : {
                cpsErrorText = ""; autoClick?.startAutoClick()
            }()}, label: {
                Text(
                    running ?
                    (autoClick?.countdown ?? 0) > 0
                    ? "\(autoClick?.countdown ?? 0)"
                    : "Start (\(controls.startButtonText))" : "Start (\(controls.startButtonText))")
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
}

#Preview {
    ContentView()
        .environmentObject(Controls())
}
