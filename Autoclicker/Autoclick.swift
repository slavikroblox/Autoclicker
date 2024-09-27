//
//  Autoclick.swift
//  Autoclicker
//
//  Created by Vyacheslav on 17.09.2024.
//

import Foundation
import Cocoa

class Autoclick {
    
    private var controlsView = ControlsView()
    
    var contentView: ContentView
    
    init(contentView: ContentView) {
        self.contentView = contentView
    }
    
    func autoclick() {
        
        let source = CGEventSource(stateID: .hidSystemState)
        
        let screenHeight = NSScreen.main!.frame.height
        let mouseLocation = NSEvent.mouseLocation
        let mouseLocationY = screenHeight - mouseLocation.y
        let mousePosition = CGPoint(x: mouseLocation.x, y: mouseLocationY)
        print("x: \(mousePosition.x), y: \(mousePosition.y)")
        
        let mouseDownEvent = CGEvent(mouseEventSource: source, mouseType: .leftMouseDown, mouseCursorPosition: mousePosition, mouseButton: .left)
        let mouseUpEvent = CGEvent(mouseEventSource: source, mouseType: .leftMouseUp, mouseCursorPosition: mousePosition, mouseButton: .left)
        CGEvent(mouseEventSource: nil, mouseType: CGEventType.mouseMoved, mouseCursorPosition: CGPointMake(100, 100), mouseButton: CGMouseButton.left)?.post(tap: CGEventTapLocation.cghidEventTap)
        
        mouseDownEvent?.postToPid(44731)
        usleep(100_000)
        mouseUpEvent?.postToPid(44731)
        print(controlsView.startButtonText)
        
    }
    
    func startAutoClick() {
        DispatchQueue.global(qos: .background).async {
            while self.contentView.running == true {
                self.autoclick()
            }
        }
    }
}
