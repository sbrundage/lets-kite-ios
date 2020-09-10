//
//  LandingViewController.swift
//  LetsKite
//
//  Created by Stephen Brundage on 9/6/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var letsFlyButton: UIButton!
    
    private var zipCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        zipTextField.delegate = self
        zipTextField.attributedPlaceholder = NSAttributedString(string: "Zip Code", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        letsFlyButton.isEnabled = false
        letsFlyButton.layer.cornerRadius = 10
        letsFlyButton.setTitleColor(.gray, for: .normal)
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        zipTextField.addTarget(self, action: #selector(textFieldDidChangeSelection(_:)), for: .allEditingEvents)
    }
    
    @objc internal func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let textFieldInput = textField.text else { return }
        
        let isValidZip: Bool = validateTextField(input: textFieldInput)
        let buttonColor: UIColor = isValidZip ? .white : .gray
        
        letsFlyButton.isEnabled = isValidZip
        letsFlyButton.setTitleColor(buttonColor, for: .normal)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
      
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - (keyboardSize.height / 2)
    }
    
    private func validateTextField(input: String) -> Bool {
        return input.count == 5
    }
    
    @IBAction func letsFlyButtonClicked(_ sender: Any) {
        guard let inputZip = zipTextField.text else { return }
        zipCode = inputZip
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? WindOutlookViewController else { return }
        
        let weatherPublisher = WeatherServicePublisher()
        
        destinationVC.weatherServicePublisher = weatherPublisher
        weatherPublisher.fetchAllWeatherForecast("", "")
    }
}

extension LandingViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let invalidCharacters = CharacterSet(charactersIn: "0123456789 ").inverted
        
        // Checks to make sure zip code string is over 5 digits
        
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
}
