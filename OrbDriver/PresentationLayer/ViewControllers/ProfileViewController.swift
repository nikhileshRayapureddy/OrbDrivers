//
//  ProfileViewController.swift
//  OrbDriver
//
//  Created by Nikhilesh on 01/12/17.
//  Copyright © 2017 Nikhilesh. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    var profileBO = ProfileBO()
    
    @IBOutlet weak var lblCarNo: UILabel!
    @IBOutlet weak var lblCarType: UILabel!
    @IBOutlet weak var lblLocation: UILabel!

    
    @IBOutlet weak var lblOwnerName: UILabel!
    @IBOutlet weak var lblOwnerPhone: UILabel!
    @IBOutlet weak var btnOwnerLanguages: UIButton!
    @IBOutlet weak var vwDriverDetails: UIView!
    
    
    @IBOutlet weak var lblDriverName: UILabel!
    @IBOutlet weak var lblDriverPhone: UILabel!
    @IBOutlet weak var btnDriverLanguages: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblCarNo.adjustsFontSizeToFitWidth = true
        lblCarType.adjustsFontSizeToFitWidth = true
        lblLocation.adjustsFontSizeToFitWidth = true
        lblOwnerName.adjustsFontSizeToFitWidth = true
        lblOwnerPhone.adjustsFontSizeToFitWidth = true
        lblDriverName.adjustsFontSizeToFitWidth = true
        lblDriverPhone.adjustsFontSizeToFitWidth = true
        btnOwnerLanguages.titleLabel?.numberOfLines = 0
        btnOwnerLanguages.titleLabel?.lineBreakMode = .byWordWrapping
        btnDriverLanguages.titleLabel?.numberOfLines = 0
        btnDriverLanguages.titleLabel?.lineBreakMode = .byWordWrapping

        self.designNavigationBarForProfile()
        app_delegate.showLoader(message: "Fetching Profile...")
        let layer = ServiceLayer()
        layer.getProfile(successMessage: { (reponse) in
            DispatchQueue.main.async {
                app_delegate.removeloder()
                self.profileBO = reponse as! ProfileBO
                self.bindData()
            }
        }) { (err) in
            DispatchQueue.main.async {
                app_delegate.removeloder()
                let alert = UIAlertController(title: "Alert!", message:err as? String, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func bindData()
    {
        lblCarNo.text = profileBO.carNo
        lblCarType.text = profileBO.carType
        lblLocation.text = profileBO.carLocation
        lblOwnerName.text = profileBO.ownerName
        lblOwnerPhone.text = profileBO.ownerPhoneNumber
        btnOwnerLanguages.setTitle(profileBO.ownerLanguages, for: .normal)
        lblDriverName.text = profileBO.driverName
        lblDriverPhone.text = profileBO.driverPhoneNumber
        btnDriverLanguages.setTitle(profileBO.driverLanguages, for: .normal)
        if profileBO.driverName == ""
        {
            vwDriverDetails.isHidden = true
        }
        else
        {
            vwDriverDetails.isHidden = false
        }
        
        
    }

    @IBAction func btnCabDetailsClicked(_ sender: UIButton) {
        let cabDetailVC = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CabDetailsViewController") as! CabDetailsViewController
        cabDetailVC.profileBO = profileBO
        self.navigationController?.pushViewController(cabDetailVC, animated: true)

    }
    
    
}
