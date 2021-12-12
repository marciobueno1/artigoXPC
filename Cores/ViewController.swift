//
//  LeftSplitViewController.swift
//  Cores
//
//  Created by Marcio Bueno on 05/12/21.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak var intervaloInput: NSTextField!
    @IBOutlet weak var intervaloStepper: NSStepper!
    @IBOutlet weak var corComboBox: NSComboBox!
    @IBOutlet weak var fundoBox: NSBox!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        intervaloInput.delegate = self
        intervaloInput.intValue = 1
        intervaloStepper.intValue = 1
        corComboBox.selectItem(at: 0)
        CoresXPCUtility.shared.reply = { valorAlpha in
            print("Recebido valor do XPC")
                DispatchQueue.main.async {
                    let cor = self.fundoBox.borderColor.withAlphaComponent(valorAlpha)
                    self.fundoBox.borderColor = cor
                    self.fundoBox.fillColor = cor
                    print("Fim da recepção do valor do XPC")
                }
        }
    }

    @IBAction func mudancaCor(_ sender: NSComboBox) {
        let red = CGFloat(sender.indexOfSelectedItem == 0 ? 1 : 0)
        let green = CGFloat(sender.indexOfSelectedItem == 1 ? 1 : 0)
        let blue = CGFloat(sender.indexOfSelectedItem == 2 ? 1 : 0)
        let alpha = fundoBox.borderColor.alphaComponent
        let cor = NSColor(red: red, green: green, blue: blue, alpha: alpha)
        fundoBox.borderColor = cor
        fundoBox.fillColor = cor
    }

    @IBAction func intervaloStepperAction(_ sender: Any) {
        intervaloInput.intValue = intervaloStepper.intValue
    }

    func controlTextDidChange(_ notification: Notification) {
        if let textField = notification.object as? NSTextField {
            if textField == intervaloInput {
                intervaloStepper.intValue = intervaloInput.intValue
            }
        }
    }

    @IBAction func iniciarAction(_ sender: NSButton) {
//        if self.geradorXPC != nil {
//            self.pararAction(sender)
//        }
        CoresXPCUtility.shared.servicoXPC().iniciarGeradorCiclicoAlpha(
            self.fundoBox.borderColor.alphaComponent,
            intervalo: intervaloInput.integerValue
        )
    }

    @IBAction func pararAction(_ sender: NSButton) {
        CoresXPCUtility.shared.servicoXPC().pararGeradorCiclicoAlpha()
        CoresXPCUtility.shared.invalidarConexao()
    }
}
