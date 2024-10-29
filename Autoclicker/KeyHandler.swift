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
    
    init(autoclick: Autoclick, contentView: ContentView, controls: Controls) {
        self.autoclick = autoclick
        self.contentView = contentView
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
        if event.keyCode == 97 {
            print("F6 key pressed")
            contentView?.running = !contentView!.running
            autoclick?.startAutoClick()
        }
    }
}
