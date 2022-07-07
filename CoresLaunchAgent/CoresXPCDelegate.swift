//
//  CoresXPCDelegate.swift
//  CoresXPC
//
//  Created by Marcio Bueno on 12/12/21.
//

import Foundation

class CoresXPCDelegate : NSObject, NSXPCListenerDelegate {
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        newConnection.exportedInterface = NSXPCInterface(with: CoresXPCProtocol.self)
        newConnection.exportedObject = CoresXPC()

        newConnection.remoteObjectInterface = NSXPCInterface(with: CoresProtocol.self)

        (newConnection.exportedObject as? CoresXPC)?.listener = newConnection.remoteObjectProxy as? CoresProtocol

        newConnection.resume()
        return true
    }
}
