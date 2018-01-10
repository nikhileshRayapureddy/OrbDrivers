//
//  LocationViewController.swift
//  OrbDriver
//
//  Created by Nikhilesh on 20/12/17.
//  Copyright © 2017 Nikhilesh. All rights reserved.
//

import UIKit

class LocationViewController: BaseViewController {
    @IBOutlet weak var btnPool: UIButton!
    @IBOutlet weak var btnGo: UIButton!
    
    @IBOutlet weak var btnAirport: UIButton!
    @IBOutlet weak var btnCity: UIButton!

    @IBOutlet weak var clVwLocations: UICollectionView!
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var vwTripSelBase: UIView!
    
    var selIndex = -1
    var arrLocations = [String]()
    var arrAirports = [String]()
    var arrSearchLocations = [String]()
    var selArea = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.designNavigationBarWithBack(strTitle: "Trip Details", isNotification: false)
        txtFldSearch.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: txtFldSearch.frame.size.width/2 - 20, y: 0, width: 20, height: 20))
        imageView.image = #imageLiteral(resourceName: "Search")
        imageView.contentMode = .scaleAspectFit
        txtFldSearch.leftView = imageView
        
        let nibName=UINib(nibName: "LocationCollectionViewCell", bundle:nil)
        self.clVwLocations.register(nibName, forCellWithReuseIdentifier: "LocationCollectionViewCell")
        app_delegate.showLoader(message: "Fetching Locations....")
        let layer = ServiceLayer()
        layer.getLocations(successMessage: { (response) in
            DispatchQueue.main.async {
                app_delegate.removeloder()
                let locations = response as! [String:[String]]
                self.arrLocations = locations["Areas"]!
                self.arrAirports = locations["Airports"]!
                if self.arrLocations.count > 0
                {
                    self.btnCityClicked(self.btnCity)
                }
                else if self.arrAirports.count > 0
                {
                    self.btnbtnAirportClicked(self.btnAirport)
                }
                
            }
        }) { (err) in
            DispatchQueue.main.async {
                app_delegate.removeloder()
            }
        }

    }
    @IBAction func btnCityClicked(_ sender: UIButton) {
        sender.isSelected = true
        btnAirport.isSelected = false
        arrSearchLocations.removeAll()
        arrSearchLocations.append(contentsOf: arrLocations)
        clVwLocations.reloadData()
        txtFldSearch.text = ""
    }
    @IBAction func btnGoClicked(_ sender: UIButton) {
        sender.isSelected = true
        btnPool.isSelected = false
    }

    @IBAction func btnPoolClicked(_ sender: UIButton) {
        sender.isSelected = true
        btnGo.isSelected = false
    }
    @IBAction func btnbtnAirportClicked(_ sender: UIButton) {
        sender.isSelected = true
        btnCity.isSelected = false
        arrSearchLocations.removeAll()
        arrSearchLocations.append(contentsOf: arrAirports)
        clVwLocations.reloadData()
        txtFldSearch.text = ""
    }
    @IBAction func btnStartTripClicked(_ sender: UIButton) {
       
        if selIndex == -1
        {
            let alert = UIAlertController(title: "Alert!", message:"Please select a location to start the trip.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
        app_delegate.showLoader(message: "Starting your trip...")
            if self.btnAirport.isSelected
            {
                selArea = arrAirports[selIndex]
            }
            else
            {
                selArea = arrLocations[selIndex]
            }
        let layer = ServiceLayer()
        layer.setTripStatus(isStart: "0", location: selArea, isAirport: String(self.btnAirport.isSelected.hashValue), isPool: String(self.btnPool.isSelected.hashValue), successMessage: { (response) in
            DispatchQueue.main.async {
                app_delegate.removeloder()
                OrbUserDefaults.setTripStatus(object: true)
                self.navigationController?.popViewController(animated: false)
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension LocationViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSearchLocations.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationCollectionViewCell", for: indexPath) as! LocationCollectionViewCell

        if selIndex == indexPath.row
        {
            customCell.lblLocName.layer.borderColor = Theme_Color.cgColor
            customCell.lblLocName.textColor = Theme_Color
            customCell.lblLocName.backgroundColor = .white
            customCell.lblLocName.layer.borderWidth = 2.0
            customCell.lblLocName.font = UIFont(name: "Roboto-Regular", size: 15)

        }
        else
        {
            customCell.lblLocName.layer.borderColor = UIColor(red: 167.0/255.0, green: 167.0/255.0, blue: 167.0/255.0, alpha: 1.0).cgColor
            customCell.lblLocName.textColor = UIColor(red: 167.0/255.0, green: 167.0/255.0, blue: 167.0/255.0, alpha: 1.0)
            customCell.lblLocName.backgroundColor = .white
            customCell.lblLocName.layer.borderWidth = 1.0
            customCell.lblLocName.font = UIFont(name: "Roboto-Light", size: 15)

            
        }
        
        customCell.lblLocName.layer.cornerRadius = 5
        customCell.lblLocName.layer.masksToBounds = true
        customCell.lblLocName.text = arrSearchLocations[indexPath.row]
        customCell.lblLocName.adjustsFontSizeToFitWidth = true
        return customCell
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: (UIScreen.main.bounds.size.width - 32)/2 - 10, height: 50)
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        selIndex = indexPath.row
        collectionView.reloadData()
    }
}
extension LocationViewController : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", textField.text! + string)
        
        var arrTemp = [String]()
        if self.btnAirport.isSelected
        {
            arrTemp.append(contentsOf: self.arrAirports)
        }
        else
        {
            arrTemp.append(contentsOf: self.arrLocations)
        }
        let array = (arrTemp as NSArray).filtered(using: searchPredicate)
        self.arrSearchLocations = array as! [String]
        self.clVwLocations.reloadData()
        self.clVwLocations.setContentOffset(CGPoint.zero, animated: false)
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.arrSearchLocations.removeAll()
        var arrTemp = [String]()
        if self.btnAirport.isSelected
        {
            arrTemp.append(contentsOf: self.arrAirports)
        }
        else
        {
            arrTemp.append(contentsOf: self.arrLocations)
        }

        self.arrSearchLocations.append(contentsOf: arrTemp)
        self.clVwLocations.reloadData()
        return true
    }
}

