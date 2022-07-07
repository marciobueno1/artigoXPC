//
//  main.swift
//  CoresLaunchAgent
//
//  Created by Marcio Bueno on 06/07/22.
//

import Foundation

let delegate = CoresXPCDelegate()
let listener = NSXPCListener(machServiceName: "br.org.cesar.CoresLaunchAgent")
listener.delegate = delegate
listener.resume()
RunLoop.main.run()
