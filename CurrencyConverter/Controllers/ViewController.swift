//
//  ViewController.swift
//  Currency Converter
//
//  Created by Vadim Samoilov on 12.02.22.
//

import UIKit


class ViewController: UIViewController {
    
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
        
        currencyManager.delegate = self
        
        errorLabel.isHidden = true
        firstTextField.delegate = self
        currencyLabelOne.text = currencyManager.currencies[0]
        
        
        secondTextField.delegate = self
        currencyLabelTwo.text = currencyManager.currencies[1]
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
// MARK: - move view while keyboard show
//    @objc func keyboardWillShow(_ notification: NSNotification) {
//        self.view.frame.origin.y = 0 - 100
//    }
    
// MARK: - move view when keyboard hide
//    @objc func keyboardWillHide(_ notification: NSNotification) {
//        self.view.frame.origin.y = 0
//    }

    var coeff: Double?
    var numb: Double?

    @IBAction func firstButtonSelect(_ sender: Any) {
        performSegue(withIdentifier: "VC1", sender: self)
    }
    
    @IBAction func secondButtonSelect(_ sender: Any) {
        performSegue(withIdentifier: "VC2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "VC1": let secondVC = segue.destination as! ViewControllerCurrencyPick
                    secondVC.numberOfField = 1
                    secondVC.completionHandler = { text in
                         self.currencyLabelOne.text = text
            }
        case "VC2": let secondVC = segue.destination as! ViewControllerCurrencyPick
                    secondVC.numberOfField = 2
                    secondVC.completionHandler = { text in
                         self.currencyLabelTwo.text = text
            }
        default: _ = segue.destination as! ViewControllerCurrencyPick
        }
    }
}

// set style for buttons

func setStyle(_ button: UIButton!) {
    button.backgroundColor = UIColor(named: "buttonColor")
    button.layer.cornerRadius = 10
    button.titleLabel?.textColor = .black
}

// adding a method that hide the keyboard
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

// MARK: - CurrencyManagerDelegate
extension ViewController: CurrencyManagerDelegate {
    
    func didUpdateRate(_ currencyManager: CurrencyManager, currencyRate: CurrencyModel) {
        DispatchQueue.main.async {
            switch currencyRate.nameOfCurrency {
            case self.currencyLabelOne.text:
                self.firstTextField.text = String(format: "%.2f", (currencyRate.rate! * self.numb!))
            default:
                self.secondTextField.text = String(format: "%.2f", (currencyRate.rate! * self.numb!))
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    // method that calculate fields editing
    func textFieldEditing(_ textField: UITextField) {
        numb = Double(textField.text ?? "0.0")
        if currencyLabelTwo.text == currencyLabelOne.text {
            coeff = 1.0
             
            if textField === firstTextField {
                secondTextField.text = String(format: "%.2f", (coeff! * numb!))
            } else {
                firstTextField.text = String(format: "%.2f", (coeff! * numb!))
            }
        }
        
        //parse json when editing first text field
        if textField === firstTextField && firstTextField.text != "" {
            currencyManager.fetchCurrencyRate(name: "\(currencyLabelOne.text!).json", currency: "\(currencyLabelTwo.text!)")
            
        //parse json when editing second text field
        } else if secondTextField.text != "" {
            currencyManager.fetchCurrencyRate(name: "\(currencyLabelTwo.text!).json", currency: "\(currencyLabelOne.text!)")
        }
        
    }
// hide the keyboard and apply changing
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldEditing(textField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if change && firstTextField.text != "" && secondTextField.text != "" {
            textFieldEditing(firstTextField)
        } else if firstTextField.text != "" && secondTextField.text != "" {
            textFieldEditing(secondTextField)
        }
    }
}
