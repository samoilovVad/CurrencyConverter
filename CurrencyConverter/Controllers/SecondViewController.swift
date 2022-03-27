//
//  SecondViewController.swift
//  Currency Converter
//
//  Created by Vadim Samoilov on 15.02.22.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UISearchBarDelegate {
    
    
    var text: String?
    public var numberOfField = 0
    let data = Data()

    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var pickCurrency: UIPickerView!
    @IBOutlet weak var searchFilter: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickCurrency.dataSource = self
        pickCurrency.delegate = self
        searchFilter.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
// MARK: move view while keyboard show
        @objc func keyboardWillShow(_ notification: NSNotification) {
            self.view.frame.origin.y = 0 - 100
        }
        
// MARK: move view when keyboard hide
        @objc func keyboardWillHide(_ notification: NSNotification) {
            self.view.frame.origin.y = 0
        }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let str = data.currencies[row]
        return str
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        text = data.currencies[row]
    }
    
    @IBAction func selectCurrency(_ sender: Any) {
       performSegue(withIdentifier: "goBack", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mainVC = segue.destination as! ViewController
        if let text = text {
            switch numberOfField {
            case 1: mainVC.currencyLabelOne.text = text
                    mainVC.change = true
            case 2: mainVC.currencyLabelTwo.text = text
                    mainVC.change = false
            default: mainVC.errorLabel.isHidden = false
            }
        }
        
    }
    
    func search(_ searchBar: UISearchBar!) {
        guard let searchText = searchBar.text else {return}
        var count = 0
        for i in data.currencies {
            if searchText == i {
                pickCurrency.selectRow(count, inComponent: 1, animated: true)
            }
            count += 1
        }
    }

}
