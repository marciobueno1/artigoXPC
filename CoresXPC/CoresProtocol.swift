//
//  CoresProtocol.swift
//  CoresXPC
//
//  Created by Marcio Bueno on 12/12/21.
//

import Foundation

@objc(CoresProtocol) public protocol CoresProtocol {
    func atualizarAlpha(_ alpha: Double)
}
