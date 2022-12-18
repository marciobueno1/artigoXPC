//
//  LeftSplitViewController.swift
//  Cores
//
//  Created by Marcio Bueno on 05/12/21.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {
    private var xpcUtility: CoresXPCUtility!

    @IBOutlet weak var intervaloInput: NSTextField!
    @IBOutlet weak var intervaloStepper: NSStepper!
    @IBOutlet weak var corComboBox: NSComboBox!
    @IBOutlet weak var fundoBox: NSBox!

    override func viewDidLoad() {
        super.viewDidLoad()
        intervaloInput.delegate = self
        intervaloInput.intValue = 1
        intervaloStepper.intValue = 1
        corComboBox.selectItem(at: 0)
        self.iniciarXpcUtility()
    }

    deinit {
        self.xpcUtility.invalidarConexao()
    }

    func iniciarXpcUtility() {
        self.xpcUtility = CoresXPCUtility(reply: { valorAlpha in
            DispatchQueue.main.async {
                let cor = self.fundoBox.borderColor.withAlphaComponent(valorAlpha)
                self.fundoBox.borderColor = cor
                self.fundoBox.fillColor = cor
            }
        })
    }

    @IBAction func mudancaCor(_ sender: NSComboBox) {
        let red = CGFloat(sender.indexOfSelectedItem == 0 ? 1 : 0)
        let green = CGFloat(sender.indexOfSelectedItem == 1 ? 1 : 0)
        let blue = CGFloat(sender.indexOfSelectedItem == 2 ? 1 : 0)
        let alpha = self.fundoBox.borderColor.alphaComponent
        let cor = NSColor(red: red, green: green, blue: blue, alpha: alpha)
        self.fundoBox.borderColor = cor
        self.fundoBox.fillColor = cor
    }

    @IBAction func intervaloStepperAction(_ sender: Any) {
        self.intervaloInput.intValue = self.intervaloStepper.intValue
    }

    func controlTextDidChange(_ notification: Notification) {
        if let textField = notification.object as? NSTextField {
            if textField == intervaloInput {
                self.intervaloStepper.intValue = self.intervaloInput.intValue
            }
        }
    }

    @IBAction func iniciarAction(_ sender: NSButton) {
        self.xpcUtility.servicoXPC().iniciarGeradorCiclicoAlpha(
            self.fundoBox.borderColor.alphaComponent,
            intervalo: intervaloInput.integerValue
        )
    }

    @IBAction func pararAction(_ sender: NSButton) {
        xpcUtility.servicoXPC().pararGeradorCiclicoAlpha()
    }
    
    @IBAction func aleatoriaAction(_ sender: Any) {
        let cor = XPCHelper.getCorAleatoria(self.xpcUtility)
        self.fundoBox.borderColor = cor
        self.fundoBox.fillColor = cor
    }
}
