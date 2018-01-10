//
//  ViewController.swift
//  OrbDriver
//
//  Created by Nikhilesh on 01/12/17.
//  Copyright © 2017 Nikhilesh. All rights reserved.
//

import UIKit
let app_delegate =  UIApplication.shared.delegate as! AppDelegate
let Theme_Color  = UIColor(red: 86.0/255.0, green: 185.0/255.0, blue: 208.0/255.0, alpha: 1.0)
class BaseViewController: UIViewController {
    var vwBottomBar = UIView()
    var btnCabDetails = UIButton()
    var btnFriends = UIButton()
    var btntabControl = UIButton()
    var btnTrip = UIButton()
    var selectedBottomTab = -1
    var vwOffline : OfflineCustomView!
    var switchOnline : UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func designNavigationBarWithBack(strTitle : String, isNotification : Bool)
    {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.barTintColor = .white
        
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -12
        
        let btnBack = UIButton(type: UIButtonType.custom)
        btnBack.frame = CGRect(x: 0, y: 0  , width: 44 , height: 44)
        btnBack.setImage(#imageLiteral(resourceName: "Back"), for: UIControlState.normal)
        btnBack.addTarget(self, action: #selector(self.btnBackClicked(sender:)), for: UIControlEvents.touchUpInside)
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: btnBack)
        self.navigationItem.leftBarButtonItems = [negativeSpacer,leftBarButtonItem]
        
        if isNotification
        {
            let btnNotification = UIButton(type: UIButtonType.custom)
            btnNotification.frame = CGRect(x: 0, y: 0  , width: 44 , height: 44)
            btnNotification.setImage(#imageLiteral(resourceName: "Notifications"), for: UIControlState.normal)
            btnNotification.addTarget(self, action: #selector(self.btnNotificationClicked(sender:)), for: UIControlEvents.touchUpInside)
//            let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: btnNotification)
//            self.navigationItem.rightBarButtonItems = [negativeSpacer,rightBarButtonItem]
        }
        
        
        let btnTitle = UIButton(type: UIButtonType.custom)
        btnTitle.frame = CGRect(x: 0, y: 5  , width: 71 , height: 34)
        btnTitle.backgroundColor = UIColor.clear
        btnTitle.setTitle(strTitle, for: .normal)
        btnTitle.titleLabel?.font = UIFont(name: "Roboto-Thin", size: 24)
        btnTitle.setTitleColor(.black, for: .normal)
        self.navigationItem.titleView = btnTitle
        
        
        
        
    }
    func designNavigationBarForProfile()
    {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.barTintColor = .white
        
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -12
        
        let btnBack = UIButton(type: UIButtonType.custom)
        btnBack.frame = CGRect(x: 0, y: 0  , width: 44 , height: 44)
        btnBack.setImage(#imageLiteral(resourceName: "Back"), for: UIControlState.normal)
        btnBack.addTarget(self, action: #selector(self.btnBackClicked(sender:)), for: UIControlEvents.touchUpInside)
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: btnBack)
        self.navigationItem.leftBarButtonItems = [negativeSpacer,leftBarButtonItem]
        
        let btnLogout = UIButton(type: UIButtonType.custom)
        btnLogout.frame = CGRect(x: 0, y: 0  , width: 44 , height: 44)
        btnLogout.backgroundColor = .clear
        btnLogout.setTitle("Logout", for: .normal)
        btnLogout.setTitleColor(Theme_Color, for: .normal)
        btnLogout.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        btnLogout.addTarget(self, action: #selector(self.btnLogoutClicked(sender:)), for: UIControlEvents.touchUpInside)
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: btnLogout)
        self.navigationItem.rightBarButtonItems = [negativeSpacer,rightBarButtonItem]
        
        
        let btnTitle = UIButton(type: UIButtonType.custom)
        btnTitle.frame = CGRect(x: 0, y: 0  , width: 71 , height: 44)
        btnTitle.backgroundColor = UIColor.clear
        btnTitle.setTitle("Profile", for: .normal)
        btnTitle.titleLabel?.font = UIFont(name: "Roboto-Thin", size: 24)
        btnTitle.setTitleColor(.black, for: .normal)
        self.navigationItem.titleView = btnTitle
        
        
        
        
    }
    @objc func btnLogoutClicked(sender : UIButton)
    {
        OrbUserDefaults.setLoginStatus(object: "false")
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController"))
        app_delegate.window!.rootViewController = navigationController
        app_delegate.window!.backgroundColor = UIColor.white
        app_delegate.window?.makeKeyAndVisible()
    }
    @objc func btnBackClicked(sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func designNavigationBar()
    {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.barTintColor = .white
        
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -12
        
        let btnProfile = UIButton(type: UIButtonType.custom)
        btnProfile.frame = CGRect(x: 0, y: 0  , width: 44 , height: 44)
        btnProfile.setImage(#imageLiteral(resourceName: "Profile"), for: UIControlState.normal)
        btnProfile.addTarget(self, action: #selector(self.btnProfileClicked(sender:)), for: UIControlEvents.touchUpInside)
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: btnProfile)
        self.navigationItem.leftBarButtonItems = [negativeSpacer,leftBarButtonItem]


        
        switchOnline = UISwitch(frame: CGRect(x: 0, y: 0, width: 44, height: 35))
        switchOnline.backgroundColor = UIColor.clear
        switchOnline.onTintColor = Theme_Color
        switchOnline.addTarget(self, action: #selector(self.switchOnlineClicked(sender:)), for: .valueChanged)
        switchOnline.isOn = true
//        let btnNotification = UIButton(type: UIButtonType.custom)
//        btnNotification.frame = CGRect(x: 0, y: 0  , width: 44 , height: 44)
//        btnNotification.setImage(#imageLiteral(resourceName: "Notifications"), for: UIControlState.normal)
//        btnNotification.addTarget(self, action: #selector(self.btnNotificationClicked(sender:)), for: UIControlEvents.touchUpInside)
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: switchOnline)
        
        self.navigationItem.rightBarButtonItems = [negativeSpacer,rightBarButtonItem]
        
        
        let btnTitle = UIButton(type: UIButtonType.custom)
        btnTitle.frame = CGRect(x: 0, y: 5  , width: 71 , height: 34)
        btnTitle.backgroundColor = UIColor.clear
        btnTitle.setImage(#imageLiteral(resourceName: "Logo"), for: .normal)
        self.navigationItem.titleView = btnTitle
        
        
        
        
    }
    @objc func switchOnlineClicked(sender:UISwitch)
    {
        if app_delegate.isServerReachable
        {
            app_delegate.showLoader(message: "Posting Action...")
            let layer = ServiceLayer()
            layer.sendActionWithType(actionType: "offline", successMessage: { (response) in
                DispatchQueue.main.async {
                    if (sender.isOn == false){
                        if let vwOfflineCustomView = Bundle.main.loadNibNamed("OfflineCustomView", owner: nil, options: nil)![0] as? OfflineCustomView
                        {
                            self.vwOffline = vwOfflineCustomView
                            self.vwOffline.frame = CGRect (x: 0, y: 20, width: (self.view.window?.bounds.width)!, height: (self.view.window?.bounds.height)! - 20)
                            self.vwOffline.btnOffline.addTarget(self, action: #selector(self.btnOfflineClicked(sender:)), for: .touchUpInside)
                            vwOfflineCustomView.alpha = 0
                            self.view.window?.addSubview(vwOfflineCustomView)
                            UIView.animate(withDuration: 0.3, animations: {
                                vwOfflineCustomView.alpha = 1
                            })
                        }
                    }
                    
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
        else
        {
            sender.isOn = true
            let alert = UIAlertController(title: "Alert!", message:"Server not responding.\nPlease try after some time.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }



    }
    
    @objc func btnOfflineClicked(sender : UIButton)
    {
        if app_delegate.isServerReachable
        {
            app_delegate.showLoader(message: "Posting Action...")
            let layer = ServiceLayer()
            layer.sendActionWithType(actionType: "online", successMessage: { (response) in
                DispatchQueue.main.async {
                    app_delegate.removeloder()
                    UIView.animate(withDuration: 0.3, animations: {
                        self.vwOffline.alpha = 0
                    }) { (isCompleted) in
                        self.vwOffline.removeFromSuperview()
                        self.switchOnline.isOn = true
                    }
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
        else
        {
            let alert = UIAlertController(title: "Alert!", message:"Server not responding.\nPlease try after some time.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    func designTabBar()
    {
        vwBottomBar.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 44 - 64, width: UIScreen.main.bounds.width, height: 44)
        vwBottomBar.backgroundColor = Theme_Color
        self.view.addSubview(vwBottomBar)
        
        
        
        btnTrip = UIButton(type: .custom)
        btnTrip.frame = CGRect(x: 0, y: 0, width: vwBottomBar.frame.size.width/4, height: vwBottomBar.frame.size.height)
        btnTrip.setImage(#imageLiteral(resourceName: "Trip"), for: .normal)
        btnTrip.setImage(#imageLiteral(resourceName: "Tripactive"), for: .selected)
        btnTrip.addTarget(self, action: #selector(btnBottomTabBarClicked(_:)), for: .touchUpInside)
        vwBottomBar.addSubview(btnTrip)
        
        btnCabDetails = UIButton(type: .custom)
        btnCabDetails.frame = CGRect(x: vwBottomBar.frame.size.width/4, y: 0, width: vwBottomBar.frame.size.width/4, height: vwBottomBar.frame.size.height)
        btnCabDetails.setImage(#imageLiteral(resourceName: "Driver_Profile"), for: .normal)
        btnCabDetails.setImage(#imageLiteral(resourceName: "Driver_Profileactive"), for: .selected)
        btnCabDetails.addTarget(self, action: #selector(btnBottomTabBarClicked(_:)), for: .touchUpInside)
        vwBottomBar.addSubview(btnCabDetails)

        btntabControl = UIButton(type: .custom)
        btntabControl.frame = CGRect(x: vwBottomBar.frame.size.width/2, y: 0, width: vwBottomBar.frame.size.width/4, height: vwBottomBar.frame.size.height)
        btntabControl.setImage(#imageLiteral(resourceName: "Tab_Screen"), for: .normal)
        btntabControl.setImage(#imageLiteral(resourceName: "Tab_Screenactive"), for: .selected)
        btntabControl.addTarget(self, action: #selector(btnBottomTabBarClicked(_:)), for: .touchUpInside)
        vwBottomBar.addSubview(btntabControl)

        btnFriends = UIButton(type: .custom)
        btnFriends.frame = CGRect(x: (vwBottomBar.frame.size.width/4) * 3, y: 0, width: vwBottomBar.frame.size.width/4, height: vwBottomBar.frame.size.height)
        btnFriends.setImage(#imageLiteral(resourceName: "Friends_Screen"), for: .normal)
        btnFriends.setImage(#imageLiteral(resourceName: "Friends_Screenactive"), for: .selected)
        btnFriends.addTarget(self, action: #selector(btnBottomTabBarClicked(_:)), for: .touchUpInside)
        vwBottomBar.addSubview(btnFriends)


    }
    
    @objc func btnBottomTabBarClicked(_ button: UIButton) {
        resetTabBarButtonUI()
        switch button {
        case btnTrip:
            if (selectedBottomTab == 1)
            {
                setSelectedButtonAtIndex(1)
                return
            }
            
            let locationViewController: LocationViewController = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
            self.navigationController?.pushViewController(locationViewController, animated: false)
            break
        case btnCabDetails:
            if (selectedBottomTab == 2)
            {
                setSelectedButtonAtIndex(2)
                return
            }
            let cabDetailsViewController: CabDetailsViewController = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CabDetailsViewController") as! CabDetailsViewController
            self.navigationController?.pushViewController(cabDetailsViewController, animated: false)
            break
        case btntabControl:
            if (selectedBottomTab == 3)
            {
                setSelectedButtonAtIndex(3)
                return
            }
            let dashBoardViewController: DashBoardViewController = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
            self.navigationController?.pushViewController(dashBoardViewController, animated: false)
            break
        case btnFriends:
            if (selectedBottomTab == 4)
            {
                setSelectedButtonAtIndex(4)
                return
            }
            let friendsViewController: FriendsViewController = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FriendsViewController") as! FriendsViewController
            self.navigationController?.pushViewController(friendsViewController, animated: false)
            break
        default:
            let dashBoardViewController: DashBoardViewController = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
            self.navigationController?.pushViewController(dashBoardViewController, animated: false)
            break
        }
        
        button.isSelected = true
    }
    func resetTabBarButtonUI()
    {
        btnCabDetails.isSelected = false
        btnFriends.isSelected = false
        btntabControl.isSelected = false
        btnTrip.isSelected = false
        
    }
    func setSelectedButtonAtIndex(_ index: Int)
    {
        selectedBottomTab = index
        switch index {
        case 1:
            btnTrip.isSelected = true
            break
        case 2:
            btnCabDetails.isSelected = true
            break
        case 3:
            btntabControl.isSelected = true
            break
        case 4:
            btnFriends.isSelected = true
            break
        default:
            break
        }
    }

    @objc func btnProfileClicked(sender:UIButton)
    {
        if app_delegate.isServerReachable
        {
            let profVC = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.navigationController?.pushViewController(profVC, animated: true)
        }
        else
        {
            let alert = UIAlertController(title: "Alert!", message:"Server not responding.\nPlease try after some time.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    @objc func btnNotificationClicked(sender:UIButton)
    {
        if app_delegate.isServerReachable
        {
            let notVC = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
            self.navigationController?.pushViewController(notVC, animated: true)
        }
        else
        {
            let alert = UIAlertController(title: "Alert!", message:"Server not responding.\nPlease try after some time.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }

}

