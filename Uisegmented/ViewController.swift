//
//  ViewController.swift
//  Uisegmented
//
//  Created by Стас Жингель on 13.08.2021.
//

import UIKit

class ViewController: UIViewController {
    var uiElements = ["UISegmentedControl","UILabel", "UISlider", "UITextField", "UIButton", "UIDatePicker"]
    var selectedElement: String?
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.value = 1
        label.text = String(slider.value)
        label.font = label.font.withSize(35)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: false)
        
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.minimumTrackTintColor = .brown
        slider.maximumTrackTintColor = .yellow
        choiseUiElement()
        createToolbar()
        
    }
    
    func hideElements() {
        segmentedControl.isHidden = true
        label.isHidden = true
        slider.isHidden = true
        datePicker.isHidden = true
    }
    func choiseUiElement() {
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        textField.inputView = elementPicker
    }

    @IBAction func segment(_ sender: UISegmentedControl) {
        label.isHidden = false
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            label.text = "segment 1"
        case 1:
            label.text = "segment 2"
        case 2:
            label.text = "segment 3"
        default:
            return
        }
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        label.text = String(round(sender.value))
    }
    
   
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func button2(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Number is not good", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        guard textField.text != "" else {
            return
        }
        if Double(textField.text!) != nil {
            present(alert, animated: false, completion: nil)
            textField.text = ""
        
        } else {
            label.text = textField.text
        }
    }
    @IBAction func changedDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        let dateValue = dateFormatter.string(from: sender.date)
        label.text = dateValue
    }
    
    @IBOutlet weak var `switch`: UILabel!
    @IBAction func switchAction(_ sender: UISwitch) {
        datePicker.isHidden = !datePicker.isHidden
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 //количество барабанов
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElements.count //количество строк
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row] //значения которые будут показаны в барабане
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedElement = uiElements[row] //присваиваем выбранному элементу значение барабана
        textField.text = selectedElement
        
        switch row {
        case 0:
            hideElements()
            segmentedControl.isHidden = false
            
        default:
            hideElements()
        }
        
    }
}
