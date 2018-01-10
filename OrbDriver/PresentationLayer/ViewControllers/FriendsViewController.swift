//
//  FriendsViewController.swift
//  OrbDriver
//
//  Created by Nikhilesh on 20/12/17.
//  Copyright © 2017 Nikhilesh. All rights reserved.
//

import UIKit
import CoreLocation

class FriendsViewController: BaseViewController {
    var locationManager = CLLocationManager()

    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnNearMe: UIButton!
    @IBOutlet weak var btnFindFriend: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.designNavigationBar()
        self.designTabBar()
        setSelectedButtonAtIndex(4)
        locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        btnLocation.autoresizesSubviews = true
        btnNearMe.autoresizesSubviews = true
        btnFindFriend.autoresizesSubviews = true

    }

    @IBAction func btnFindFriendClicked(_ sender: UIButton) {
        let friendDetailVC = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FriendsDetailViewController") as! FriendsDetailViewController
        friendDetailVC.isNearMe = false
        friendDetailVC.isFindFriend = true
        friendDetailVC.isLocation = false
        self.navigationController?.pushViewController(friendDetailVC, animated: true)

    }
    @IBAction func btnLocationClicked(_ sender: UIButton) {
        let friendDetailVC = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FriendsDetailViewController") as! FriendsDetailViewController
        friendDetailVC.isNearMe = false
        friendDetailVC.isFindFriend = false
        friendDetailVC.isLocation = true
        self.navigationController?.pushViewController(friendDetailVC, animated: true)
    }
    @IBAction func btnNearMeClicked(_ sender: UIButton) {
        let friendDetailVC = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FriendsDetailViewController") as! FriendsDetailViewController
        friendDetailVC.isNearMe = true
        friendDetailVC.isFindFriend = false
        friendDetailVC.isLocation = false
        self.navigationController?.pushViewController(friendDetailVC, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension FriendsViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}
