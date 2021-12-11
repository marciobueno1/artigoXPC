//
//  CoresXPCProtocol.swift
//  CoresXPC
//
//  Created by Marcio Bueno on 05/12/21.
//

import Foundation

@objc public protocol CoresXPCProtocol {
    func upperCaseString(_ string: String, withReply reply: @escaping (String) -> Void)
}
