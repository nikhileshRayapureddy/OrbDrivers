//
//  AppDelegate.swift
//  OrbDriver
//
//  Created by Nikhilesh on 01/12/17.
//  Copyright © 2017 Nikhilesh. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isServerReachable : Bool = false
    var reachability: Reachability?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.sharedManager().enable = true
        
        if OrbUserDefaults.getLoginStatus() == "true"
        {
            let navigationController: UINavigationController = UINavigationController.init(rootViewController: UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashBoardViewController"))
            self.window!.rootViewController = navigationController
            self.window!.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
//            navigationController.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate

        }
        else
        {
            let navigationController: UINavigationController = UINavigationController.init(rootViewController: UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController"))
            self.window!.rootViewController = navigationController
            self.window!.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
//            navigationController.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        }
        self.setupReachability(hostName: "", useClosures: true)
        self.startNotifier()
        print("reachable = ",isServerReachable)
        isServerReachable = (reachability?.isReachable)!
        print("reachable after= ",isServerReachable)
        UserDefaults.standard.register(defaults: ["video" : true])

        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "OrbDriver")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    //MARK:- Loader  methods
    func showLoader(message : String)
    {
        DispatchQueue.main.async {

        let vwBgg = self.window!.viewWithTag(123453)
        if vwBgg == nil
        {
            let vwBg = UIView( frame:self.window!.frame)
            vwBg.backgroundColor = UIColor.clear
            vwBg.tag = 123453
            self.window!.addSubview(vwBg)
            
            let imgVw = UIImageView (frame: vwBg.frame)
            imgVw.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            vwBg.addSubview(imgVw)
            
            let height = vwBg.frame.size.height/2.0
            
            let lblText = UILabel(frame:CGRect(x: 0, y: height-60, width: vwBg.frame.size.width, height: 30))
            lblText.font = UIFont(name: "OpenSans", size: 17)
            
            if message == ""
            {
                lblText.text =  "Loading ..."
            }
            else
            {
                lblText.text = message
            }
            lblText.textAlignment = NSTextAlignment.center
            lblText.backgroundColor = UIColor.clear
            lblText.textColor =   UIColor.white// Color_AppGreen
            // lblText.textColor = Color_NavBarTint
            vwBg.addSubview(lblText)
            
            let indicator = UIActivityIndicatorView(activityIndicatorStyle:.whiteLarge)
            indicator.center = vwBg.center
            vwBg.addSubview(indicator)
            indicator.startAnimating()
            
            vwBg.addSubview(indicator)
            indicator.bringSubview(toFront: vwBg)
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
        }
        }
    }
    func removeloder()
    {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
            let vwBg = self.window!.viewWithTag(123453)
            if vwBg != nil
            {
                vwBg!.removeFromSuperview()
            }
        }
        
    }
    func setupReachability(hostName: String?, useClosures: Bool) {
        
        let reachabil = hostName == "" ? Reachability() : Reachability(hostname: hostName!)
        reachability = reachabil
        if useClosures {
            reachability?.whenReachable = { reachability in
                DispatchQueue.main.async {
                    self.isServerReachable = true
                }
            }
            reachability?.whenUnreachable = { reachability in
                DispatchQueue.main.async {
                    self.isServerReachable = false
                }
            }
            print("reachable setup = ",isServerReachable)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: reachability)
        }
    }
    
    func startNotifier() {
        print("--- start notifier")
        do {
            try reachability?.startNotifier()
        } catch {
            
            return
        }
    }
    
    func stopNotifier() {
        print("--- stop notifier")
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: nil)
        reachability = nil
    }
    @objc func reachabilityChanged(_ note: Notification) {
        let reachability = note.object as! Reachability
        
        if reachability.isReachable {
            isServerReachable = true
        } else {
            isServerReachable = false
        }
    }
    
    deinit {
        stopNotifier()
    }

}

