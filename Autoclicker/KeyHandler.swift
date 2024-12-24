//
//  KeyHandler.swift
//  Autoclicker
//
//  Created by Vyacheslav on 29.10.2024.
//

import Cocoa
import Foundation
import Combine

class KeyHandler {
    var autoclick: Autoclick?
    var contentView: ContentView?
    var controls: Controls
    
    init(autoclick: Autoclick, contentView: ContentView, controls: Controls) {
        self.autoclick = autoclick
        self.contentView = contentView
        self.controls = controls
        setupKeyMonitoring()
    }

    private func setupKeyMonitoring() {
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            self?.handleKeyPress(event)
            return event
        }

        NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] event in
            self?.handleKeyPress(event)
        }
    }
    
    private func handleKeyPress(_ event: NSEvent) {
        if  let startKeyCode = controls.keyCodes[controls.startButtonText], event.keyCode == startKeyCode  {
            print("\(controls.startButtonText) key pressed (start action)")
            print("start key code: \(startKeyCode)")
            contentView?.running = true
            autoclick?.startAutoClick()
        } else if let stopKeyCode = controls.keyCodes[controls.stopButtonText], event.keyCode == stopKeyCode {
            print("\(controls.stopButtonText) key pressed (stop action)")
            print("stop key code: \(stopKeyCode)")
            contentView?.running = false
        }
    }
}
