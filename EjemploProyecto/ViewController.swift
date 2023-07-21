//
//  ViewController.swift
//  EjemploProyecto
//
//  Created by Jonathan Casillas on 19/07/23.
//

import UIKit

class ViewController: UIViewController {
    
    //Outless
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myPickerView: UIPickerView!
    @IBOutlet weak var myPageControl: UIPageControl!
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var myStepper: UIStepper!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var myProgressView: UIProgressView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myStepperLabel: UILabel!
    @IBOutlet weak var mySwitchLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myTextView: UITextView!
    
    
    // Variables
    private let myPickerViewValues = ["Uno", "Dos", "Tres", "Cuatro", "Cinco"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Buttons
        myButton.setTitle("Mi Button", for: .normal)
        myButton.backgroundColor = .blue
        myButton.setTitleColor(.white, for: .normal)
        
        // Pickers
        myPickerView.backgroundColor = .lightGray
        myPickerView.dataSource = self
        myPickerView.delegate = self
        myPickerView.isHidden = true
        
        //PageControl
        myPageControl.numberOfPages = myPickerViewValues.count
        myPageControl.currentPageIndicatorTintColor = .blue
        myPageControl.pageIndicatorTintColor = .lightGray
        
        //SegmentedControl
        mySegmentedControl.removeAllSegments()
        for(index, value) in myPickerViewValues.enumerated(){
            mySegmentedControl.insertSegment(withTitle: value, at: index, animated: true)
        }
        
        //Slider
        mySlider.minimumTrackTintColor = .orange
        mySlider.minimumValue = 1
        mySlider.maximumValue = Float(myPickerViewValues.count)
        mySlider.value = 1
        
        //Stepper
        myStepper.minimumValue = 0
        myStepper.maximumValue = Double(myPickerViewValues.count - 1)
        
        //Switch
        mySwitch.onTintColor = .purple
        mySwitch.isOn = false
        
        //ProgressView
        myProgressView.progress = 0
        
        //Activity Indicator
        myActivityIndicator.color = .black
        myActivityIndicator.startAnimating()
        myActivityIndicator.hidesWhenStopped = true
        
        //Labels
        myStepperLabel.textColor = .darkGray
        myStepperLabel.font = UIFont.boldSystemFont(ofSize: 24)
        myStepperLabel.text = "1"
        
        mySwitchLabel.text = "Está apagado"
        
        //TextField
        myTextField.textColor = .brown
        myTextField.placeholder = "Escribe algo"
        myTextField.delegate = self
        
        //TextView
        myTextView.textColor = .brown
        //myTextView.isEditable = false
        myTextView.delegate = self
        
    }
    
    //Actions
    
    //Button
    @IBAction func myButtonAction(_ sender: Any) {
        if myButton.backgroundColor == .blue {
            myButton.backgroundColor = .magenta
        }else {
            myButton.backgroundColor = .blue
        }
        
        myTextView.resignFirstResponder()
        
    }
    
    //PageControl
    @IBAction func myPageControlAction(_ sender: Any) {
        myPickerView.selectRow(myPageControl.currentPage, inComponent: 0, animated: true)
        let myString = myPickerViewValues[myPageControl.currentPage]
        myButton.setTitle(myString, for: .normal)
        mySegmentedControl.selectedSegmentIndex = myPageControl.currentPage
        mySlider.value = Float(myPageControl.currentPage + 1)
        myStepper.value = Double(myPageControl.currentPage)
        myProgressView.progress = Float(myPageControl.currentPage) * 0.25
        myStepperLabel.text = "\(myPageControl.currentPage + 1)"
    }
    
    //SegmentControl
    @IBAction func mySegmentedControlAction(_ sender: Any) {
        myButton.setTitle( myPickerViewValues[mySegmentedControl.selectedSegmentIndex] , for: .normal)
        myPickerView.selectRow(mySegmentedControl.selectedSegmentIndex , inComponent: 0, animated: true)
        myPageControl.currentPage = mySegmentedControl.selectedSegmentIndex
        mySlider.value = Float(mySegmentedControl.selectedSegmentIndex + 1)
        myStepper.value = Double(mySegmentedControl.selectedSegmentIndex)
        myProgressView.progress = Float(mySegmentedControl.selectedSegmentIndex) * 0.25
        myStepperLabel.text = "\(mySegmentedControl.selectedSegmentIndex + 1)"
    }
    
    //Slider
    @IBAction func mySliderAction(_ sender: Any) {
        
        var progress: Float = 0
        
        switch mySlider.value {
        case 1..<2:
            mySegmentedControl.selectedSegmentIndex = 0
            myButton.setTitle(myPickerViewValues[0], for: .normal)
            myPickerView.selectRow(0, inComponent: 0, animated: true)
            myPageControl.currentPage = 0
            myStepper.value = 0
            progress = 0
            myStepperLabel.text = "1"
        case 2..<3:
            mySegmentedControl.selectedSegmentIndex = 1
            myButton.setTitle(myPickerViewValues[1], for: .normal)
            myPickerView.selectRow(1, inComponent: 0, animated: true)
            myPageControl.currentPage = 1
            myStepper.value = 1
            progress = 0.25
            myStepperLabel.text = "2"
        case 3..<4:
            mySegmentedControl.selectedSegmentIndex = 2
            myButton.setTitle(myPickerViewValues[2], for: .normal)
            myPickerView.selectRow(2, inComponent: 0, animated: true)
            myPageControl.currentPage = 2
            myStepper.value = 2
            progress = 0.5
            myStepperLabel.text = "3"
        case 4..<5:
            mySegmentedControl.selectedSegmentIndex = 3
            myButton.setTitle(myPickerViewValues[3], for: .normal)
            myPickerView.selectRow(3, inComponent: 0, animated: true)
            myPageControl.currentPage = 3
            myStepper.value = 3
            progress = 0.75
            myStepperLabel.text = "4"
        default:
            mySegmentedControl.selectedSegmentIndex = 4
            myButton.setTitle(myPickerViewValues[4], for: .normal)
            myPickerView.selectRow(4, inComponent: 0, animated: true)
            myPageControl.currentPage = 4
            myStepper.value = 4
            progress = 1
            myStepperLabel.text = "5"
        }
        
        myProgressView.progress = progress
    }
    
    //Stepper
    @IBAction func myStepperAction(_ sender: Any) {
        let value = myStepper.value
        mySlider.value = Float(value + 1)
        mySegmentedControl.selectedSegmentIndex = Int(value)
        myButton.setTitle(myPickerViewValues[Int(value)], for: .normal)
        myPickerView.selectRow(Int(value), inComponent: 0, animated: true)
        myPageControl.currentPage = Int(value)
        myProgressView.progress = Float(value * 0.25)
        myStepperLabel.text = "\(Int(value) + 1)"
    }
    
    //Switch
    @IBAction func mySwitchAction(_ sender: Any) {
        if mySwitch.isOn {
            myPickerView.isHidden = false
            myActivityIndicator.stopAnimating()
            mySwitchLabel.text = "Está encendido"
        }else {
            myPickerView.isHidden = true
            myActivityIndicator.startAnimating()
            mySwitchLabel.text = "Está apagado"
        }
    }
    
    
}

//UIPickerViewDataSource, UIPickerViewDelegate
extension ViewController: UIPickerViewDataSource,
                          UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerViewValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerViewValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let myString = myPickerViewValues[row]
        myButton.setTitle(myString, for: .normal)
        myPageControl.currentPage = row
        mySegmentedControl.selectedSegmentIndex = row
        mySlider.value = Float(row + 1)
        myStepper.value = Double(row)
        myProgressView.progress = Float(row) * 0.25
        myStepperLabel.text = "\(row + 1)"
    }
    

}

//UITextFieldDelegate
extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        myButton.setTitle(myTextField.text, for: .normal)
    }
    
}

//UITextViewDelegate
extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        myTextField.isHidden = true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        myTextField.isHidden = false
    }
}



