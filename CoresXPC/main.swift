//
//  main.swift
//  CoresXPC
//
//  Created by Marcio Bueno on 05/12/21.
//

import Foundation

let delegate = CoresXPCDelegate()
let listener = NSXPCListener.service()
listener.delegate = delegate
listener.resume()
