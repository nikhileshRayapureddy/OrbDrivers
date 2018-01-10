//
//  FriendsDetailViewController.swift
//  OrbDriver
//
//  Created by Nikhilesh on 20/12/17.
//  Copyright © 2017 Nikhilesh. All rights reserved.
//

import UIKit
import MapKit
class FriendsDetailViewController: BaseViewController {
    let regionRadius: CLLocationDistance = 1000
    @IBOutlet weak var vwBtnBg: UIView!
    
    @IBOutlet weak var constVwBtnBgHeight: NSLayoutConstraint!
    @IBOutlet weak var constSearchbarHeight: NSLayoutConstraint!
    @IBOutlet weak var tblFriends: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var txtFldSearch: UITextField!
    var isNearMe = false
    var isLocation = false
    var isFindFriend = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView.layer.cornerRadius = 10
        mapView.layer.masksToBounds = true
        mapView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        mapView.layer.borderWidth = 1
        if isNearMe
        {
            constSearchbarHeight.constant = 0
            txtFldSearch.isHidden = true
            constVwBtnBgHeight.constant = 50
            vwBtnBg.isHidden = false
            centerMapOnLocation(location: CLLocation(latitude: 17.425813, longitude: 78.420231))
            self.designNavigationBarWithBack(strTitle: "Near Me", isNotification: true)
        }
        else if isFindFriend
        {
            constVwBtnBgHeight.constant = 0
            constSearchbarHeight.constant = 40
            txtFldSearch.isHidden = false
            vwBtnBg.isHidden = true
            txtFldSearch.leftViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: txtFldSearch.frame.size.width/2 - 20, y: 0, width: 40, height: 20))
            imageView.image = #imageLiteral(resourceName: "Search")
            imageView.contentMode = .scaleAspectFit
            txtFldSearch.leftView = imageView

            self.designNavigationBarWithBack(strTitle: "Find Friend", isNotification: true)
        }
        else if isLocation
        {
            constVwBtnBgHeight.constant = 50
            constSearchbarHeight.constant = 40
            txtFldSearch.isHidden = false
            vwBtnBg.isHidden = false
            txtFldSearch.leftViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: txtFldSearch.frame.size.width/2 - 20, y: 0, width: 40, height: 20))
            imageView.image = #imageLiteral(resourceName: "Search")
            imageView.contentMode = .scaleAspectFit
            txtFldSearch.leftView = imageView

            centerMapOnLocation(location: CLLocation(latitude: 17.425813, longitude: 78.420231))
            self.designNavigationBarWithBack(strTitle: "Location", isNotification: true)
        }
        else
        {
            constSearchbarHeight.constant = 0
            constVwBtnBgHeight.constant = 0
            txtFldSearch.isHidden = true
            vwBtnBg.isHidden = true

        }
    }
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension FriendsDetailViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsTableViewCell", for: indexPath) as! NotificationsTableViewCell
        cell.vwCellBg.layer.cornerRadius = 10
        cell.vwCellBg.layer.masksToBounds = true

        cell.imgVwProfilePic.layer.cornerRadius = 25
        cell.imgVwProfilePic.layer.masksToBounds = true
        cell.imgVwProfilePic.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        cell.imgVwProfilePic.layer.borderWidth = 1.0
        cell.imgVwProfilePic.image = #imageLiteral(resourceName: "image")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let addFriendVC = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddFriendViewController") as! AddFriendViewController
        self.navigationController?.pushViewController(addFriendVC, animated: true)
        
    }
}
