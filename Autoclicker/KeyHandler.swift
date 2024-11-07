//
//  KeyHandler.swift
//  Autoclicker
//
//  Created by Vyacheslav on 29.10.2024.
//

import Cocoa
import Foundation

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
        if controls.keyCodes[controls.startButtonText] == controls.keyCodes[controls.stopButtonText] {
            if event.keyCode == controls.keyCodes[controls.startButtonText] {
                print("\(controls.startButtonText) pressed")
                contentView?.running = !contentView!.running
                autoclick?.startAutoClick()
            }
        } else {
            if event.keyCode == controls.keyCodes[controls.startButtonText] {
                print("\(controls.startButtonText) key pressed (start action)")
                contentView?.running = true
                autoclick?.startAutoClick()
            } else if event.keyCode == controls.keyCodes[controls.stopButtonText] {
                print("\(controls.stopButtonText) key pressed (stop action)")
                contentView?.running = false
            }
        }
    }
}
