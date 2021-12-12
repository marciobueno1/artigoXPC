//
//  AppDelegate.swift
//  Cores
//
//  Created by Marcio Bueno on 05/12/21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    override init() {
        // CoresXPCUtility.shared.servicoXPC().pararGeradorCiclicoAlpha()
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

}

