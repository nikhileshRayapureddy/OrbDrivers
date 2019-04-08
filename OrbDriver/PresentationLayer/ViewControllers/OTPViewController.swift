//
//  OTPViewController.swift
//  OrbDriver
//
//  Created by Nikhilesh on 20/12/17.
//  Copyright © 2017 Nikhilesh. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var txtFldOTP1: UITextField!
    @IBOutlet weak var txtFldOTP2: UITextField!
    @IBOutlet weak var txtFldOTP3: UITextField!
    @IBOutlet weak var txtFldOTP4: UITextField!
    @IBOutlet weak var txtFldOTP5: UITextField!
    @IBOutlet weak var txtFldOTP6: UITextField!
    var mobileNo = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        txtFldOTP1.delegate = self
        txtFldOTP2.delegate = self
        txtFldOTP3.delegate = self
        txtFldOTP4.delegate = self
        txtFldOTP5.delegate = self
        txtFldOTP6.delegate = self
        txtFldOTP1.becomeFirstResponder()
        
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFldOTP1 || textField == txtFldOTP2 || textField == txtFldOTP3 || textField == txtFldOTP4 || textField == txtFldOTP5 || textField == txtFldOTP6
        {
            guard let text = textField.text else { return true }
            
            let newLength = text.count + string.count - range.length
            if newLength <= 1
            {
                if newLength == 0
                {
                    if textField == txtFldOTP6
                    {
                        txtFldOTP6.text = ""
                        txtFldOTP5.becomeFirstResponder()
                        return false
                    }
                    else if textField == txtFldOTP5
                    {
                        txtFldOTP5.text = ""
                        txtFldOTP4.becomeFirstResponder()
                        return false
                    }

                    else if textField == txtFldOTP4
                    {
                        txtFldOTP4.text = ""
                        txtFldOTP3.becomeFirstResponder()
                        return false
                    }
                    else if textField == txtFldOTP3
                    {
                        txtFldOTP3.text = ""
                        txtFldOTP2.becomeFirstResponder()
                        return false
                    }
                    else if textField == txtFldOTP2
                    {
                        txtFldOTP2.text = ""
                        txtFldOTP1.becomeFirstResponder()
                        return false
                    }
                    else if textField == txtFldOTP1
                    {
                        
                    }
                }
                else
                {
                    if textField == txtFldOTP1
                    {
                        txtFldOTP1.text = string
                        txtFldOTP2.becomeFirstResponder()
                        return false
                    }
                    else if textField == txtFldOTP2
                    {
                        txtFldOTP2.text = string
                        txtFldOTP3.becomeFirstResponder()
                        return false
                        
                    }
                    else if textField == txtFldOTP3
                    {
                        txtFldOTP3.text = string
                        txtFldOTP4.becomeFirstResponder()
                        return false
                    }
                    else if textField == txtFldOTP4
                    {
                        txtFldOTP4.text = string
                        txtFldOTP5.becomeFirstResponder()
                        return false
                    }
                    else if textField == txtFldOTP5
                    {
                        txtFldOTP5.text = string
                        txtFldOTP6.becomeFirstResponder()
                        return false
                    }
                    else if textField == txtFldOTP6
                    {
                        txtFldOTP6.text = string
                        var strOtp = txtFldOTP1.text! + txtFldOTP2.text! + txtFldOTP3.text!
                        strOtp = strOtp + txtFldOTP4.text! + txtFldOTP5.text! + txtFldOTP6.text!
                        app_delegate.showLoader(message: "Sending OTP....")
                        let layer = ServiceLayer()
                        layer.checkLoginWith(mobileNo: mobileNo, Otp: strOtp, successMessage: { (reponse) in
                            DispatchQueue.main.async {
                                app_delegate.removeloder()
                                OrbUserDefaults.setLoginStatus(object: "true")
                                let featVC = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FeaturesViewController") as! FeaturesViewController
                                self.navigationController?.pushViewController(featVC, animated: true)

                            }
                        }, failureMessage: { (error) in
                            DispatchQueue.main.async {
                                app_delegate.removeloder()
                                let alert = UIAlertController(title: "Alert!", message:error as? String, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }

                        })
                        return false

                    }
                }
                
            }
            else
            {
                if textField == txtFldOTP1
                {
                    txtFldOTP2.text = string
                    txtFldOTP2.becomeFirstResponder()
                }
                else if textField == txtFldOTP2
                {
                    txtFldOTP3.text = string
                    txtFldOTP3.becomeFirstResponder()
                }
                else if textField == txtFldOTP3
                {
                    txtFldOTP4.text = string
                    txtFldOTP4.becomeFirstResponder()
                }
                else if textField == txtFldOTP4
                {
                    txtFldOTP5.text = string
                    txtFldOTP5.becomeFirstResponder()
                }
                else if textField == txtFldOTP5
                {
                    txtFldOTP6.text = string
                    txtFldOTP6.becomeFirstResponder()
                    var strOtp = txtFldOTP1.text! + txtFldOTP2.text! + txtFldOTP3.text!
                    strOtp = strOtp + txtFldOTP4.text! + txtFldOTP5.text! + txtFldOTP6.text!
                    app_delegate.showLoader(message: "Sending OTP....")
                    let layer = ServiceLayer()
                    layer.checkLoginWith(mobileNo: mobileNo, Otp: strOtp, successMessage: { (reponse) in
                        DispatchQueue.main.async {
                            app_delegate.removeloder()
                            OrbUserDefaults.setLoginStatus(object: "true")
                            let featVC = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FeaturesViewController") as! FeaturesViewController
                            self.navigationController?.pushViewController(featVC, animated: true)
                            
                        }
                    }, failureMessage: { (error) in
                        DispatchQueue.main.async {
                            app_delegate.removeloder()
                            let alert = UIAlertController(title: "Alert!", message:error as? String, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    })

                }
                else if textField == txtFldOTP6
                {
                    return false
                    
                }
            }
            
            
        
            
            return newLength <= 1 // Bool
        }        else{
            
            return true
        }
        
    }

    @IBAction func btnResetNumberClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
