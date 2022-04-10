//
//  TraductionViewController.swift
//  Le Baluchon
//
//  Created by Dusan Orescanin on 28/03/2022.
//

import UIKit

class TranslatorViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    // MARK: - IBOutlet

    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var textToTranslateTextfield: UITextField!
    @IBOutlet weak var texteWasTranslatedLabel: UILabel!
    
    private var reversalArrowButton: Bool = false
    
    private var target: String = "en"
    private var source: String = "fr"
    
    private var text1 = ""
    private var text2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        texteWasTranslatedLabel.text = ""
        textToTranslateTextfield.placeholder = "Saisissez votre texte"
    }
    
    // MARK: - IBAction

    @IBAction func reversalButtonTapped() {
        manageReversalButton()
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textToTranslateTextfield.resignFirstResponder()
    }
}
// MARK: - MANAGE API CALL

extension TranslatorViewController {
    // Make API Call private function
    private func makeAPICall() {
        TranslateService.shared.getTranslation(for: textToTranslateTextfield.text ?? "", target: target, source: source) { [self] (result) in
            switch result {
            case .some(let response):
                self.updateTranslatorDisplay(response: response)
            case .none:
            presentAlert()
            }
        }
    }
    // Update translation display function
    private func updateTranslatorDisplay(response: TranslationResponse) {
        if textToTranslateTextfield.text != "" {
            text1 = textToTranslateTextfield.text ?? ""
            text2 = response.data.translations[0].translatedText
            self.texteWasTranslatedLabel.text = response.data.translations[0].translatedText
        } else {
            texteWasTranslatedLabel.text = ""
        }
    }
}

// MARK: - MANAGE REVERSAL BUTTON

extension TranslatorViewController {
    // Reversal translation button FR -> EN & EN -> FR
    private func manageReversalButton() {
        /// Translation French -> English
        if reversalArrowButton {
            reversalArrowButton = false
            sourceLabel.text = "Français"
            targetLabel.text = "Anglais"
            target = "en"
            source = "fr"
            textToTranslateTextfield.placeholder = "Saisissez votre texte"
        } else {
            /// Translation English -> French
            reversalArrowButton = true
            sourceLabel.text = "Anglais"
            targetLabel.text = "Français"
            target = "fr"
            source = "en"
            textToTranslateTextfield.placeholder = "Write your text"
        }
        if textToTranslateTextfield.text?.isEmpty == false {
          let text3 = text1
          text1 = text2
          text2 = text3
          textToTranslateTextfield.text = text1
          texteWasTranslatedLabel.text = text2
        }
    }
}

// MARK: - MANAGE TEXTFIELD

extension TranslatorViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        makeAPICall()
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty { texteWasTranslatedLabel.text = "" }
    }
}

// MARK: - PRESENTE ALERTS

extension TranslatorViewController {
    
    private func presentAlert() {
        let alertVC = UIAlertController.init(title: "Une erreur est survenue", message: "Erreur de chargement", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

