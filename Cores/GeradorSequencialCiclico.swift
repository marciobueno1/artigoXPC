//
//  GeradorSequencialCiclico.swift
//  Cores
//
//  Created by Marcio Bueno on 11/12/21.
//

import Foundation

class GeradorSequencialCiclico {
    private var callback: ((Double)->Void)?
    private var timer: Timer?
    private var intervalo: Double
    private(set) var valorAtual = 0
    private var gerarErro: Int?

    init(intervalo: Double) {
        self.intervalo = intervalo
    }

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

    func iniciar(valorInicial: Double, callback: @escaping (Double)->Void) {
        self.valorAtual = Int((valorInicial * 10).rounded())
        self.callback = callback
        self.timer = Timer.scheduledTimer(
            timeInterval: self.intervalo,
            target: self,
            selector: #selector(alterarValorAutomaticamente),
            userInfo: nil,
            repeats: true
        )
    }

    func parar() {
        self.timer?.invalidate()
        self.timer = nil
        self.callback = nil
    }
}
