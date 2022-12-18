//
//  CoresXPCProtocol.swift
//  CoresXPC
//
//  Created by Marcio Bueno on 05/12/21.
//

import Cocoa
import Foundation

@objc(CoresXPCProtocol) public protocol CoresXPCProtocol {
    func iniciarGeradorCiclicoAlpha(_ alphaAtual: Double, intervalo: Int)
    func pararGeradorCiclicoAlpha()
    func getCorAleatoria() async -> NSColor
}
