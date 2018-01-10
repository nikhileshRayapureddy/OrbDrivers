//
//  CabDetailsViewController.swift
//  OrbDriver
//
//  Created by Nikhilesh on 20/12/17.
//  Copyright © 2017 Nikhilesh. All rights reserved.
//

import UIKit
import MapKit

class CabDetailsViewController: BaseViewController {

    var profileBO = ProfileBO()
    var driverActivityBO = DriverActivityBO()
    @IBOutlet weak var btnmonth: UIButton!
    @IBOutlet weak var btnWeek: UIButton!
    @IBOutlet weak var btnDay: UIButton!
    @IBOutlet weak var lblRegNum: UILabel!
    @IBOutlet weak var lbDriver: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.designNavigationBarWithBack(strTitle: "", isNotification: false)
        let btnTitle = UIButton(type: UIButtonType.custom)
        btnTitle.frame = CGRect(x: 0, y: 5  , width: 71 , height: 34)
        btnTitle.backgroundColor = UIColor.clear
        btnTitle.setImage(#imageLiteral(resourceName: "Logo"), for: .normal)
        self.navigationItem.titleView = btnTitle
        self.bindData()

        app_delegate.showLoader(message: "Fetching Profile...")
        let layer = ServiceLayer()
        layer.getCabActivity(successMessage: { (response) in
            DispatchQueue.main.async {
                app_delegate.removeloder()
                self.driverActivityBO = response as! DriverActivityBO
                self.btnDayClicked(self.btnDay)
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
    func bindData()
    {
        lblRegNum.text = profileBO.carNo
        lbDriver.text = profileBO.driverName == "" ? profileBO.ownerName : profileBO.driverName
    }
    @IBAction func btnDayClicked(_ sender: UIButton) {
        btnWeek.isSelected = false
        btnmonth.isSelected = false
        sender.isSelected = true
        lblDuration.text = driverActivityBO.todayDuration

    }
    @IBAction func btnWeekClicked(_ sender: UIButton) {
        btnDay.isSelected = false
        btnmonth.isSelected = false
        sender.isSelected = true
        lblDuration.text = driverActivityBO.thisWeekDuration
    }
    @IBAction func btnMonthClicked(_ sender: UIButton) {
        btnWeek.isSelected = false
        btnDay.isSelected = false
        sender.isSelected = true
        lblDuration.text = driverActivityBO.thismonthDuration

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
