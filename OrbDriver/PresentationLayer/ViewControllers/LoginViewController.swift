//
//  ViewController.swift
//  TaksyKraft
//
//  Created by Nikhilesh on 29/06/17.
//  Copyright © 2017 TaksyKraft. All rights reserved.
//

import UIKit
import Contacts

class LoginViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtFldMobileNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnGetOTPClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        if self.txtFldMobileNumber.text != ""
        {
            app_delegate.showLoader(message: "Generating OTP....")
            let layer = ServiceLayer()
            layer.loginWithEmailId(mobileNo: self.txtFldMobileNumber.text!, successMessage: { (response) in
                DispatchQueue.main.async {
                    app_delegate.removeloder()
                    let OTPVC = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                    OTPVC.mobileNo = self.txtFldMobileNumber.text!
                    self.navigationController?.pushViewController(OTPVC, animated: true)
                }
            }) { (error) in
                DispatchQueue.main.async {
                    app_delegate.removeloder()
                    let alert = UIAlertController(title: "Alert!", message:error as? String, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        else
        {
            let alert = UIAlertController(title: "Alert!", message:"Please enter your Mobile Number.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func fetchContacts()
    {
        let store = CNContactStore()
        store.requestAccess(for: .contacts, completionHandler: {
            granted, error in
            
            guard granted else {
                let alert = UIAlertController(title: "Can't access contact", message: "Please go to Settings -> MyApp to enable contact permission", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey] as [Any]
            let request = CNContactFetchRequest(keysToFetch: keysToFetch as! [CNKeyDescriptor])
            var cnContacts = [CNContact]()
            
            do {
                try store.enumerateContacts(with: request){
                    (contact, cursor) -> Void in
                    cnContacts.append(contact)
                }
            } catch let error {
                print("Fetch contact error: \(error)")
            }
            
            print(">>>> Contact list:")
            var arrNumbers = [String]()
            for contact in cnContacts {
                let fullName = CNContactFormatter.string(from: contact, style: .fullName) ?? "No Name"
                for number in contact.phoneNumbers
                {
                    var num = number.value.stringValue
                    num = num.replacingOccurrences(of: "-", with: "")
                    num = num.replacingOccurrences(of: "(", with: "")
                    num = num.replacingOccurrences(of: ")", with: "")
                    num = num.replacingOccurrences(of: " ", with: "")
                    arrNumbers.append(num)
                    
                    print("\(fullName) : \(number.value.stringValue)" )
                }
            }
            print("arr Numbers : \(arrNumbers.description)" )

        })
        
        
    }

}
extension LoginViewController : UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lblTitle.isHidden = true
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        lblTitle.isHidden = false
    }
}
