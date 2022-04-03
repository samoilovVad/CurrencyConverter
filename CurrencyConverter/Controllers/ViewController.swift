//
//  ViewController.swift
//  Currency Converter
//
//  Created by Vadim Samoilov on 12.02.22.
//

//Requirements:
//
//4 currencies are supported: BYN, EUR, RUB, USD. Exchange rates are static, hard code.
//For example:
//BYN/EUR = 2.0
//EUR/BYN = 1.99
//RUB/EUR = 10.0
//EUR/RUB = 9.09
//
//On the application launch screen, display the application name, author name and version.
//
//There are 2 screens: number input screen, currency selection screen.
//
//The first screen contains 2 fields for entering the numeric value of the currency.
//Each field contains the entered number with two decimal places, the flag of the corresponding country, the currency code and a button to go to the currency selection screen.
//For example, if a user enters a numeric value for the currency BYN, the value in EUR is updated when each new character (number) is entered.
//Also, the user can enter the EUR value to get back to BYN.
//The currency selection screen contains a list of available currencies.
//For each currency, the flag of the corresponding country and the currency code are displayed.
//
//Design at the discretion of the candidate.
//
//Optional 0: Add a filter search to the 2nd screen.
//Optional 1: Use a local JSON file instead of static hard code courses.
//Optional 2: Dark Mode, Landscape mode.
//Optional 3: Instead of static hard code values, use an API that provides course values.

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    var currencyManager = CurrencyManager()
    public var change = true
    
    

    @IBOutlet weak var secondButtonSelect: UIButton!
    @IBOutlet weak var firstButtonSelect: UIButton!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var currencyLabelOne: UILabel!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var currencyLabelTwo: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
        setStyle(firstButtonSelect)
        setStyle(secondButtonSelect)
        
        errorLabel.isHidden = true
        firstTextField.delegate = self
        currencyLabelOne.text = currencyManager.currencies[0]
        
        
        secondTextField.delegate = self
        currencyLabelTwo.text = currencyManager.currencies[1]
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
// MARK: move view while keyboard show
//    @objc func keyboardWillShow(_ notification: NSNotification) {
//        self.view.frame.origin.y = 0 - 100
//    }
    
// MARK: move view when keyboard hide
//    @objc func keyboardWillHide(_ notification: NSNotification) {
//        self.view.frame.origin.y = 0
//    }
    
// MARK: method that calculate fields editing
    func textFieldEditing(_ textField: UITextField) {
        if currencyLabelTwo.text == currencyLabelOne.text {
            let coeff = Double(1)
            let numb = Double(textField.text ?? "0.0")
            if textField === firstTextField {
                secondTextField.text = String(format: "%.2f", (coeff * numb!))
            } else {
                firstTextField.text = String(format: "%.2f", (coeff * numb!))
            }
        }
        
        guard let currencyOneToCurrencyTwo = currencyManager.rate[(currencyLabelOne.text! + currencyLabelTwo.text!)] else {return}
        guard let currencyTwoToCurrencyOne = currencyManager.rate[(currencyLabelTwo.text! + currencyLabelOne.text!)] else {return}
        if currencyLabelOne == currencyLabelTwo {
            
        }
        let numb = Double(textField.text ?? "0.0")
        if textField === firstTextField && firstTextField.text != "" {
            secondTextField.text = String(format: "%.2f", (currencyOneToCurrencyTwo * numb!))
        } else if secondTextField.text != "" {
            firstTextField.text = String(format: "%.2f", (currencyTwoToCurrencyOne * numb!))
        }
        
    }
// MARK: hide the keyboard and apply changing
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let _ = textField.text {
            currencyManager.fetchCurrencyRate(name: "usd.json")
        }
        textFieldEditing(textField)
    }

    override func viewWillAppear(_ animated: Bool) {
        if change && firstTextField.text != "" && secondTextField.text != "" {
            textFieldEditing(firstTextField)
        } else if firstTextField.text != "" && secondTextField.text != "" {
            textFieldEditing(secondTextField)
        }
    }

    

    @IBAction func firstButtonSelect(_ sender: Any) {
        performSegue(withIdentifier: "VC1", sender: self)
    }
    
    @IBAction func secondButtonSelect(_ sender: Any) {
        performSegue(withIdentifier: "VC2", sender: self)
    }
    
    @IBAction func unwindTo(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "VC1": let secondVC = segue.destination as! SecondViewController
                    secondVC.numberOfField = 1
        case "VC2": let secondVC = segue.destination as! SecondViewController
                    secondVC.numberOfField = 2
        default: _ = segue.destination as! SecondViewController
        }
    }
}

// MARK: set style for buttons

func setStyle(_ button: UIButton!) {
    button.backgroundColor = UIColor(named: "buttonColor")
    button.layer.cornerRadius = 10
    button.titleLabel?.textColor = .black
}

// MARK: adding a method that hide the keyboard
extension UIViewController {
func dismissKeyboard() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action:    #selector(UIViewController.dismissKeyboardTouchOutside))
       tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
       view.endEditing(true)
    }
}

