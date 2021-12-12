//
//  CoresXPC.swift
//  CoresXPC
//
//  Created by Marcio Bueno on 05/12/21.
//

import Foundation

class CoresXPC: NSObject, CoresXPCProtocol, NSXPCListenerDelegate {
    var listener : CoresProtocol?
    private var sourceTimer: DispatchSourceTimer?
    private var intervalo = 1
    private(set) var valorAtual = 0

    override init() {
        super.init()
        print("CoresXPC - init: \(self)")
    }

    deinit {
        print("CoresXPC - deinit")
        self.pararGeradorCiclicoAlpha()
    }

    func iniciarGeradorCiclicoAlpha(_ alphaAtual: Double, intervalo: Int) {
        print("CoresXPC - iniciarGeradorCiclicoAlpha")
        self.valorAtual = Int((alphaAtual * 10).rounded())
        self.sourceTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        self.sourceTimer?.schedule(deadline: DispatchTime.now(), repeating: .seconds(self.intervalo))
        self.sourceTimer?.setEventHandler(handler: DispatchWorkItem(block: {
            self.alterarValorAutomaticamente()
        }))
        self.sourceTimer?.resume()
    }

    func pararGeradorCiclicoAlpha() {
        print("CoresXPC - pararGeradorCiclicoAlpha")
        self.sourceTimer?.cancel()
        self.sourceTimer = nil
    }

    private func alterarValorAutomaticamente() {
        print("CoresXPC - alterarValorAutomaticamente: \(String(describing: self.listener))")
        self.valorAtual = (self.valorAtual + 1) % 11
//        if self.valorAtual == 3 {
//            UnsafeMutablePointer<Int>(bitPattern: 0)!.pointee = 100
//        }
        self.listener?.atualizarAlpha(Double(self.valorAtual) / 10.0)
    }
}
