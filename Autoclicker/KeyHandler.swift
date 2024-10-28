//
//  KeyHandler.swift
//  Autoclicker
//
//  Created by Vyacheslav on 17.10.2024.
//
//  Doesn't work right now :(
//

import Foundation
import AppKit
import Cocoa

class KeyHandler {
    private var globalMonitor: Any?
    private var localMonitor: Any?
    
    init() {
        startGlobalMonitoring()
        startLocalMonitoring()
    }
    
    func startGlobalMonitoring() {
        globalMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] event in
            self?.handleKeyPress(event, source: "Global")
        }
    }
    
    func startLocalMonitoring() {
        localMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            self?.handleKeyPress(event, source: "Local")
            return event
        }
    }
    
    func stopMonitoring() {
        if let globalMonitor = globalMonitor {
            NSEvent.removeMonitor(globalMonitor)
        }
        if let localMonitor = localMonitor {
            NSEvent.removeMonitor(localMonitor)
        }
    }
    
    private func handleKeyPress(_ event: NSEvent, source: String) {
        if event.keyCode == 97 {
            print("F6 key pressed")
        }
    }
    
    deinit {
        stopMonitoring()
    }
}

let keyHandler = KeyHandler()
