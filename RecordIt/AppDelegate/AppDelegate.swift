//
//  AppDelegate.swift
//  RecordIt
//
//  Created by Amrinder on 12/10/23.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusBarMenu: NSMenu!
    var statusItem: NSStatusItem!
    var menuItem1: NSMenuItem!
    var timer: Timer?
    var totalTime = 0.0 {
        didSet {
            statusItem.button?.title = totalTime.asString()
        }
    }
    var startTime: Date?

    var isStarted = false


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.setupStatuBar()
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

}
