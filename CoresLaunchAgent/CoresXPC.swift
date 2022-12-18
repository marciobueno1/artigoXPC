//
//  CoresXPC.swift
//  CoresXPC
//
//  Created by Marcio Bueno on 05/12/21.
//

import Cocoa
import Foundation

class CoresXPC: NSObject, CoresXPCProtocol {
    var listener : CoresProtocol?
    private var geradorCiclico = GeradorSequencialCiclico()

    func iniciarGeradorCiclicoAlpha(_ alphaAtual: Double, intervalo: Int) {
        self.geradorCiclico.iniciar(alphaAtual, intervalo: intervalo) { alpha in
            self.listener?.atualizarAlpha(alpha)
        }
    }

    func pararGeradorCiclicoAlpha() {
        self.geradorCiclico.parar()
    }
    
    func getCorAleatoria() async -> NSColor {
        let red = CGFloat.random(in: 0.0...1.0)
        let green = CGFloat.random(in: 0.0...1.0)
        let blue = CGFloat.random(in: 0.0...1.0)
        let alpha = CGFloat.random(in: 0.0...1.0)
        return NSColor(red: red, green: green, blue: blue, alpha: alpha)

    }

}
