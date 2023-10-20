//
//  Appdelegate+Extension.swift
//  RecordIt
//
//  Created by Amrinder on 20/10/23.
//

import Cocoa

extension AppDelegate {

    func setupStatuBar() {
        let statusBar = NSStatusBar.system
        statusItem = statusBar.statusItem(withLength: 80)
        statusItem.button?.title = "0s"
        statusItem.button?.image = NSImage(systemSymbolName: "dollarsign.circle", accessibilityDescription: nil)
        self.setupStatusMenuItems()
    }

    func setupStatusMenuItems() {
        statusBarMenu = NSMenu(title: "Status Bar Menu")

        menuItem1 = NSMenuItem(title: "Start Working", action: #selector(updateTimerStatuss), keyEquivalent: "start")
        statusBarMenu.addItem(menuItem1)

        statusBarMenu.addItem(withTitle: "Quit", action: #selector(quit), keyEquivalent: "quit")

        statusItem.menu = statusBarMenu
    }

    @objc func updateTimerStatuss() {
        if !isStarted {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startTimerVal), userInfo: nil, repeats: true)
            startTime = Date()
        } else {
            stopTimer()
        }
        isStarted.toggle()
        onUpdatedTimerStatus()
    }

    func onUpdatedTimerStatus() {
        menuItem1.title = isStarted ? "Stop Working" : "Start Working"
        NotificationCenter.default.post(Notification(name: Notification.Name("timerStatusUpdated")))
    }

    @objc func startTimerVal(timer: Timer) {
        totalTime += 1
        NotificationCenter.default.post(Notification(name: Notification.Name("timerRecord")))
    }

    private func stopTimer() {
        timer?.invalidate()
    }

    @objc func quit() {
        NSApplication.shared.terminate(self)
    }

}
