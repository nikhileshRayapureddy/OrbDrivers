//
//  AddFriendViewController.swift
//  OrbDriver
//
//  Created by Nikhilesh on 20/12/17.
//  Copyright © 2017 Nikhilesh. All rights reserved.
//

import UIKit

class AddFriendViewController: BaseViewController {

    @IBOutlet weak var btnmonth: UIButton!
    @IBOutlet weak var btnWeek: UIButton!
    @IBOutlet weak var btnDay: UIButton!

    @IBOutlet weak var btnAddFriend: UIButton!
    @IBOutlet weak var lblAddFriend: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.designNavigationBarWithBack(strTitle: "Mahesh", isNotification: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnDayClicked(_ sender: UIButton) {
        btnWeek.isSelected = false
        btnmonth.isSelected = false
        sender.isSelected = true
    }
    @IBAction func btnWeekClicked(_ sender: UIButton) {
        btnDay.isSelected = false
        btnmonth.isSelected = false
        sender.isSelected = true
    }
    @IBAction func btnMonthClicked(_ sender: UIButton) {
        btnWeek.isSelected = false
        btnDay.isSelected = false
        sender.isSelected = true
    }

    @IBAction func btnAddFriendClicked(_ sender: UIButton) {
        if sender.titleLabel?.text?.lowercased() == "add friend"
        {
            lblAddFriend.isHidden = true
            sender.setImage(UIImage(), for: .normal)
            sender.setTitle("Friends", for: .normal)
        }
    }

}
