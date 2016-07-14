//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    var emailAccepted = false
    var emailConfirmed = false
    var phoneAccepted = false
    var passwordAccepted = false
    var passwordConfirmed = false
    
    //constraint properties
    //var emailTextFieldLeftConstraint = NSLayoutConstraint()
    var emailTextFieldCenterConstraint = NSLayoutConstraint()
    var submitButtonBottomConstraint = NSLayoutConstraint()
    var submitButtonTopConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.removeConstraints(self.view.constraints)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Do any additional setup after loading the view, typically from a nib.
        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
        
        self.submitButton.enabled = false
        
        
        //-------------- CONSTRAINTS AND ANCHORS --------------\\
        // emailTextField
        self.emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.emailTextField.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: 40).active = true
        self.emailTextField.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.5).active = true
        self.emailTextFieldCenterConstraint = self.emailTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor)
        self.emailTextFieldCenterConstraint.active = true
        
        // emailConfirmationTextField
        self.emailConfirmationTextField.translatesAutoresizingMaskIntoConstraints = false
        self.emailConfirmationTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.emailConfirmationTextField.topAnchor.constraintEqualToAnchor(self.emailTextField.bottomAnchor, constant: 20).active = true
        self.emailConfirmationTextField.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.5).active = true
        // phoneTextField
        self.phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        self.phoneTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.phoneTextField.topAnchor.constraintEqualToAnchor(self.emailConfirmationTextField.bottomAnchor, constant: 20).active = true
        self.phoneTextField.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.5).active = true
        // passwordTextField
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.passwordTextField.topAnchor.constraintEqualToAnchor(self.phoneTextField.bottomAnchor, constant: 20).active = true
        self.passwordTextField.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.5).active = true
        // passwordConfirmTextField
        self.passwordConfirmTextField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordConfirmTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.passwordConfirmTextField.topAnchor.constraintEqualToAnchor(self.passwordTextField.bottomAnchor, constant: 20).active = true
        self.passwordConfirmTextField.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.5).active = true
        // submitButton
        self.submitButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.submitButtonBottomConstraint = self.submitButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -50)
        self.submitButtonBottomConstraint.active = true
        
        //delegate assignments
        self.emailTextField.delegate = self
        self.emailConfirmationTextField.delegate = self
        self.phoneTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordConfirmTextField.delegate = self
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        //print("editing stuff")
        switch textField {
        case self.emailTextField:
            if emailTextField.text?.containsString("@") == true && emailTextField.text?.containsString(".") == true {
                //print("accepted")
                self.emailAccepted = true
                self.emailTextField.backgroundColor = UIColor.whiteColor()
            }
            else {
                print("wrong input")
                self.emailAccepted = false
                self.popTextfield(self.emailTextField)
            }
        case self.emailConfirmationTextField:
            if emailTextField.text == self.emailConfirmationTextField.text {
                //print("accepted")
                self.emailConfirmed = true
                self.emailConfirmationTextField.backgroundColor = UIColor.whiteColor()
            }
            else {
                //print("wrong input")
                self.emailConfirmed = false
                self.popTextfield(self.emailConfirmationTextField)
            }
        case self.phoneTextField:
            if self.phoneTextField.text?.characters.count >= 7 {
                //print("accepted")
                self.phoneAccepted = true
                self.phoneTextField.backgroundColor = UIColor.whiteColor()
            }
            else {
                //print("wrong input")
                self.phoneAccepted = false
                self.popTextfield(self.phoneTextField)
            }
        case self.passwordTextField:
            if self.passwordTextField.text?.characters.count >= 6 {
                //print("accepted")
                self.passwordAccepted = true
                self.passwordTextField.backgroundColor = UIColor.whiteColor()
            }
            else {
                //print("wrong input")
                self.passwordAccepted = false
                self.popTextfield(self.passwordTextField)
            }
        case self.passwordConfirmTextField:
            if self.passwordConfirmTextField.text == self.passwordTextField.text {
                //print("accepted")
                self.passwordConfirmed = true
                self.passwordConfirmTextField.backgroundColor = UIColor.whiteColor()
            }
            else {
                //print("wrong input")
                passwordConfirmed = false
                self.popTextfield(self.passwordConfirmTextField)
            }
        default:
            break;
        }
        
        if self.isAllGood() {
            self.submitButton.enabled = true
        }
    }
    
    func isAllGood() -> Bool {
        if self.emailAccepted && self.emailConfirmed && self.phoneAccepted && self.passwordAccepted && self.passwordConfirmed {
            self.submitButtonBottomConstraint.active = false
            self.submitButtonTopConstraint = self.submitButton.topAnchor.constraintEqualToAnchor(self.passwordConfirmTextField.bottomAnchor, constant: 40)
            self.submitButtonTopConstraint.active = true
            return true
        }
        return false
    }
    
    func popTextfield(textField: UITextField) {
        UIView.animateWithDuration(0.1, delay: 0.0, options: [.Autoreverse, .Repeat], animations: {
            UIView.setAnimationRepeatCount(2.0)
            textField.transform = CGAffineTransformMakeScale(0.95, 0.95)
            textField.backgroundColor = UIColor.redColor()
            }, completion: {(true) in textField.transform = CGAffineTransformMakeScale(1.0, 1.0)})
    }

}