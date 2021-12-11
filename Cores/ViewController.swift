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

    var gerador: GeradorSequencialCiclico?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        intervaloInput.delegate = self
        intervaloInput.intValue = 1
        intervaloStepper.intValue = 1
        corComboBox.selectItem(at: 0)
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
        if self.gerador != nil {
            self.pararAction(sender)
        }
        self.gerador = GeradorSequencialCiclico(intervalo: Double(intervaloInput.integerValue))
        self.gerador?.iniciar(valorInicial: self.fundoBox.borderColor.alphaComponent, callback: { valorAlpha in
            let cor = self.fundoBox.borderColor.withAlphaComponent(valorAlpha)
            self.fundoBox.borderColor = cor
            self.fundoBox.fillColor = cor
        })
    }

    @IBAction func pararAction(_ sender: NSButton) {
        self.gerador?.parar()
        self.gerador = nil
    }
}
