//
//  NotificationsViewController.swift
//  OrbDriver
//
//  Created by Nikhilesh on 20/12/17.
//  Copyright © 2017 Nikhilesh. All rights reserved.
//

import UIKit

class NotificationsViewController: BaseViewController {

    @IBOutlet weak var tblnotifications: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.designNavigationBarWithBack(strTitle: "Notifications", isNotification: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension NotificationsViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsTableViewCell", for: indexPath) as! NotificationsTableViewCell
//        cell.vwCellBg.layer.cornerRadius = 10
//        cell.vwCellBg.layer.masksToBounds = true
        
        cell.imgVwProfilePic.layer.cornerRadius = 25
        cell.imgVwProfilePic.layer.masksToBounds = true
        cell.imgVwProfilePic.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        cell.imgVwProfilePic.layer.borderWidth = 1.0
        cell.imgVwProfilePic.image = #imageLiteral(resourceName: "image")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let profVC = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(profVC, animated: true)

    }
}

