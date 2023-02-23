//
//  ViewController.swift
//  Tipsy
//
//  Created by George on 17.02.2023.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    var tipsValues: [UIButton : Double]!
    
    override func viewDidLoad() {
        
        tipsValues = [
            zeroPctButton! : 0.0,
            tenPctButton! : 0.1,
            twentyPctButton! : 0.2
        ]
        
        super.viewDidLoad()
        
        
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        tip = tipsValues[sender]!
        sender.isSelected = true
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        guard let billTotal = Double(billTextField.text!) else {
            return
        }
        
        if(billTotal < 0){
            return
        }
        
        let result = billTotal * (1 + tip) / Double(numberOfPeople)
        finalResult = String(format: "%.2f", result)
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResults" {
            
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
        }
    }
}

