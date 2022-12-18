//
//  CoresXPCUtility.swift
//  Cores
//
//  Created by Marcio Bueno on 11/12/21.
//

import Foundation

class CoresXPCUtility: NSObject {
    private var reply: (Double) -> Void
    private var conexao: NSXPCConnection!

    init(reply: @escaping (Double) -> Void) {
        self.reply = reply
    }

    private func conectar() {
        self.conexao = NSXPCConnection(machServiceName: "br.org.cesar.CoresLaunchAgent")

        self.conexao.remoteObjectInterface = NSXPCInterface(with: CoresXPCProtocol.self)

        self.conexao.exportedObject = self
        self.conexao.exportedInterface = NSXPCInterface(with: CoresProtocol.self)

        self.conexao.interruptionHandler = {
            NSLog("Conexão interrompida")
            self.conexao = nil
        }

        self.conexao.invalidationHandler = {
            NSLog("Conexão invalidada")
            self.conexao = nil
        }

        self.conexao.resume()
    }

    func invalidarConexao() {
        guard self.conexao == nil else {
            NSLog("Sem conexão para invalidar")
            return
        }
        self.conexao.invalidate()
    }

    @objc public func servicoXPC() -> CoresXPCProtocol {
        if self.conexao == nil {
            self.conectar()
        }
        return self.conexao.remoteObjectProxyWithErrorHandler { (error) in
            NSLog("Erro de conexão ao recuperar serviço: ", error.localizedDescription)
        } as! CoresXPCProtocol
    }
}

extension CoresXPCUtility: CoresProtocol {
    func atualizarAlpha(_ alpha: Double) {
        self.reply(alpha)
    }
}
