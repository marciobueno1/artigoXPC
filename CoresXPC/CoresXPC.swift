//
//  CoresXPC.swift
//  CoresXPC
//
//  Created by Marcio Bueno on 05/12/21.
//

import Foundation

class CoresXPC: NSObject, CoresXPCProtocol {
    func upperCaseString(_ string: String, withReply reply: @escaping (String) -> Void) {
        let response = string.uppercased()
        reply(response)
    }
}
