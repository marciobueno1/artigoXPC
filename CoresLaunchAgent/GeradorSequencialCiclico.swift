//
//  GeradorSequencialCiclico.swift
//  Cores
//
//  Created by Marcio Bueno on 11/12/21.
//

import Foundation

class GeradorSequencialCiclico {
    private var callback: ((Double)->Void)!
    private var sourceTimer: DispatchSourceTimer?
    private var valorAtual = 0

    deinit {
        self.parar()
    }

    @objc private func alterarValorAutomaticamente() {
        self.valorAtual = (self.valorAtual + 1) % 11
        self.callback?(Double(self.valorAtual) / 10.0)
        if self.valorAtual == 3 {
            UnsafeMutablePointer<Int>(bitPattern: 0)!.pointee = 100
        }
    }

    func iniciar(_ valorInicial: Double, intervalo: Int, callback: @escaping (Double)->Void) {
        if self.sourceTimer != nil {
            self.parar()
        }
        self.valorAtual = Int((valorInicial * 10).rounded())
        self.callback = callback
        self.sourceTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        self.sourceTimer?.schedule(deadline: DispatchTime.now(), repeating: .seconds(intervalo))
        self.sourceTimer?.setEventHandler(handler: DispatchWorkItem(block: {
            self.alterarValorAutomaticamente()
        }))
        self.sourceTimer?.resume()
    }

    func parar() {
        self.sourceTimer?.cancel()
        self.sourceTimer = nil
        self.callback = nil
    }
}
