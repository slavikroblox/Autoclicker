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
    private var timesClicked : Int = 0
    
    var contentView: ContentView
    
    var interval: TimeInterval {
        return 1.0 / contentView.cps
    }
    
    init(contentView: ContentView) {
        self.contentView = contentView
    }
    
    
    
    func autoclick() {
        let mousePosition = NSEvent.mouseLocation
        let clickPositon = CGPoint(x: self.contentView.xPosition, y: self.contentView.yPosition)
        if let screenHeight = NSScreen.main?.frame.height {
            let correctedPosition = CGPoint(x: mousePosition.x, y: screenHeight - mousePosition.y)
            
            if self.contentView.positionType == "manual" {
                if self.contentView.mouseButton == "left" {
                    let mouseDown = CGEvent(mouseEventSource: nil, mouseType: .leftMouseDown, mouseCursorPosition: clickPositon, mouseButton: .left)
                    mouseDown?.timestamp = UInt64(interval)
                    mouseDown?.post(tap: .cghidEventTap)
                    
                    let mouseUp = CGEvent(mouseEventSource: nil, mouseType: .leftMouseUp, mouseCursorPosition: clickPositon, mouseButton: .left)
                    mouseUp?.timestamp = UInt64(interval)
                    mouseUp?.post(tap: .cghidEventTap)
                } else if self.contentView.mouseButton == "right" {
                    let mouseDown = CGEvent(mouseEventSource: nil, mouseType: .rightMouseDown, mouseCursorPosition: clickPositon, mouseButton: .right)
                    mouseDown?.timestamp = UInt64(interval)
                    mouseDown?.post(tap: .cghidEventTap)
                    
                    let mouseUp = CGEvent(mouseEventSource: nil, mouseType: .rightMouseUp, mouseCursorPosition: clickPositon, mouseButton: .right)
                    mouseUp?.timestamp = UInt64(interval)
                    mouseUp?.post(tap: .cghidEventTap)
                } else if self.contentView.mouseButton == "middle" {
                    let mouseDown = CGEvent(mouseEventSource: nil, mouseType: .otherMouseDown, mouseCursorPosition: clickPositon, mouseButton: .center)
                    mouseDown?.timestamp = UInt64(interval)
                    mouseDown?.post(tap: .cghidEventTap)
                    
                    let mouseUp = CGEvent(mouseEventSource: nil, mouseType: .otherMouseUp, mouseCursorPosition: clickPositon, mouseButton: .center)
                    mouseUp?.timestamp = UInt64(interval)
                    mouseUp?.post(tap: .cghidEventTap)
                }
            } else if self.contentView.positionType == "mouse_follow" {
                if self.contentView.mouseButton == "left" {
                    let mouseDown = CGEvent(mouseEventSource: nil, mouseType: .leftMouseDown, mouseCursorPosition: correctedPosition, mouseButton: .left)
                    mouseDown?.timestamp = UInt64(interval)
                    mouseDown?.post(tap: .cghidEventTap)
                    
                    let mouseUp = CGEvent(mouseEventSource: nil, mouseType: .leftMouseUp, mouseCursorPosition: correctedPosition, mouseButton: .left)
                    mouseUp?.timestamp = UInt64(interval)
                    mouseUp?.post(tap: .cghidEventTap)
                } else if self.contentView.mouseButton == "right" {
                    let mouseDown = CGEvent(mouseEventSource: nil, mouseType: .rightMouseDown, mouseCursorPosition: correctedPosition, mouseButton: .right)
                    mouseDown?.timestamp = UInt64(interval)
                    mouseDown?.post(tap: .cghidEventTap)
                    
                    let mouseUp = CGEvent(mouseEventSource: nil, mouseType: .rightMouseUp, mouseCursorPosition: correctedPosition, mouseButton: .right)
                    mouseUp?.timestamp = UInt64(interval)
                    mouseUp?.post(tap: .cghidEventTap)
                } else if self.contentView.mouseButton == "middle" {
                    let mouseDown = CGEvent(mouseEventSource: nil, mouseType: .otherMouseDown, mouseCursorPosition: correctedPosition, mouseButton: .center)
                    mouseDown?.timestamp = UInt64(interval)
                    mouseDown?.post(tap: .cghidEventTap)
                    
                    let mouseUp = CGEvent(mouseEventSource: nil, mouseType: .otherMouseUp, mouseCursorPosition: correctedPosition, mouseButton: .center)
                    mouseUp?.timestamp = UInt64(interval)
                    mouseUp?.post(tap: .cghidEventTap)
                }
            }
        }
    }
        
    func startAutoClick() {
        if self.contentView.timerBeforeStart > 0 {
            self.contentView.running = true
            DispatchQueue.main.asyncAfter(deadline: .now() + self.contentView.timerBeforeStart) {
                DispatchQueue.global(qos: .background).async {
                    if self.contentView.repeatType == "times" {
                        while self.contentView.running == true && self.timesClicked < self.contentView.repeatTimes {
                            self.autoclick()
                            self.timesClicked += 1
                            Thread.sleep(forTimeInterval: self.interval)
                        }
                        print("Clicked \(self.timesClicked) times. Ending autoclick.")
                        self.contentView.running = false
                        self.timesClicked = 0
                    } else if self.contentView.repeatType == "until_stop" {
                        while self.contentView.running == true {
                            self.autoclick()
                            Thread.sleep(forTimeInterval: self.interval)
                        }
                    } else {
                        while self.contentView.running == true {
                            self.autoclick()
                            Thread.sleep(forTimeInterval: self.interval)
                        }
                    }
                }
            }
        } else {
            DispatchQueue.global(qos: .background).async {
                if self.contentView.repeatType == "times" {
                    while self.contentView.running == true && self.timesClicked < self.contentView.repeatTimes {
                        self.autoclick()
                        self.timesClicked += 1
                        Thread.sleep(forTimeInterval: self.interval)
                    }
                    print("Clicked \(self.timesClicked) times. Ending autoclick.")
                    self.contentView.running = false
                    self.timesClicked = 0
                } else if self.contentView.repeatType == "until_stop" {
                    while self.contentView.running == true {
                        self.autoclick()
                        Thread.sleep(forTimeInterval: self.interval)
                    }
                } else {
                    while self.contentView.running == true {
                        self.autoclick()
                        Thread.sleep(forTimeInterval: self.interval)
                    }
                }
            }
        }
    }
}
