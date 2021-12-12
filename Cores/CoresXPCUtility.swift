//
//  CoresXPCUtility.swift
//  Cores
//
//  Created by Marcio Bueno on 11/12/21.
//

import Foundation
import CoresXPC

class CoresXPCUtility {
    static var shared: CoresXPCUtility = {
        let instance = CoresXPCUtility()
        return instance
    }()

    private init() {
        print("CoresXPCUtility - init")
    }

    var conexao: NSXPCConnection!
    var reply: ((Double) -> Void)?

    private func conectar() {
        self.conexao = NSXPCConnection(serviceName: "br.org.cesar.CoresXPC")

        self.conexao.remoteObjectInterface = NSXPCInterface(with: CoresXPCProtocol.self)

        self.conexao.exportedObject = self
        self.conexao.exportedInterface = NSXPCInterface(with: CoresProtocol.self)

        self.conexao.interruptionHandler = {
          print("conexão interrompida")
        }

        self.conexao.invalidationHandler = {
          print("conexão invalidada")
          self.conexao = nil
        }

        self.conexao.resume()
        print("CoresXPCUtility - conectar")
    }

    func invalidarConexao() {
        guard self.conexao == nil else {
            print("sem conexão para invalidar")
            return
        }
        self.conexao.invalidate()
    }

    public func servicoXPC() -> CoresXPCProtocol {
        print("CoresXPCUtility - service")
        if self.conexao == nil {
            self.conectar()
        }
        return self.conexao.remoteObjectProxyWithErrorHandler { (error) in
            print("connection error: ", error.localizedDescription)
        } as! CoresXPCProtocol
    }
}

extension CoresXPCUtility: CoresProtocol {
    func atualizarAlpha(_ alpha: Double) {
        print("CoresXPCUtility - atualizarAlpha")
        DispatchQueue.main.async {
            self.reply?(alpha)
        }
    }
}
