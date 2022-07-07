//
//  CoresXPC.swift
//  CoresXPC
//
//  Created by Marcio Bueno on 05/12/21.
//

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

}
