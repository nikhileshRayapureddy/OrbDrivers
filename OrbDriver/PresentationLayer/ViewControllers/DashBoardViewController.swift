//
//  DashBoardViewController.swift
//  OrbDriver
//
//  Created by Nikhilesh on 20/12/17.
//  Copyright © 2017 Nikhilesh. All rights reserved.
//

import UIKit
var btnNextPath = CGMutablePath()
var btnPrevPath = CGMutablePath()
var btnShufflePath = CGMutablePath()
var btnReplayPath = CGMutablePath()
//var btnTripStatusPath = CGMutablePath()

var btnNext = UIButton()
var btnPrev = UIButton()
var btnShuffle = UIButton()
var btnReplay = UIButton()
//var btnTripStatus = UIButton()

class DashBoardViewController: BaseViewController {


    
    @IBOutlet weak var vwBase: UIView!
    @IBOutlet weak var vwRectController: UIView!
    @IBOutlet weak var lblTripStatus: UILabel!
    @IBOutlet weak var btnTripStatus: UIButton!

    @IBOutlet weak var btnVideo: UIButton!
    @IBOutlet weak var btnRadio: UIButton!
    @IBOutlet weak var btnMute: UIButton!
    @IBOutlet weak var vwTripStatus: UIView!
    @IBOutlet weak var imgTripStatus: UIImageView!
    @IBOutlet weak var imgContorlsBg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.designNavigationBar()

        // Do any additional setup after loading the view.
        vwRectController.layer.borderColor = UIColor(red: 186.0/255.0, green: 186.0/255.0, blue: 186.0/255.0, alpha: 1.0).cgColor
        vwRectController.layer.borderWidth = 1.0
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Trip Status : \(OrbUserDefaults.getTripStatus())")
        if OrbUserDefaults.getVideoMode()
        {
            self.btnVideo.isSelected = true
            self.btnRadio.isSelected = false
        }
        else
        {
            self.btnVideo.isSelected = false
            self.btnRadio.isSelected = true
        }
        if OrbUserDefaults.getMuteStatus()
        {
            self.btnMute.isSelected = true
        }
        else
        {
            self.btnMute.isSelected = false
        }
        self.designTabControl()
    }
    func designTabControl()
    {
        let width = UIScreen.main.bounds.size.width - 70
        let circleColor = UIColor.clear

        btnShuffle = UIButton(type: .custom)
        btnShuffle.frame = CGRect(x: 0, y: 0, width: width, height: 0.3 * width)
        btnShuffle.setImage(#imageLiteral(resourceName: "Shuff"), for: .normal)
        btnShuffle.backgroundColor = .clear
        btnShuffle.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 17, right: 0)
        btnShuffle.addTarget(self, action: #selector(btnShuffleClicked(_:)), for: .touchUpInside)
        vwBase.addSubview(btnShuffle)
        
        btnNext = UIButton(type: .custom)
        btnNext.frame = CGRect(x: 0.7 * width, y: 0, width: 0.3 * width, height: width)
        btnNext.backgroundColor = .clear
        btnNext.setImage(#imageLiteral(resourceName: "Next"), for: .normal)
        btnNext.contentEdgeInsets = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 0)
        btnNext.addTarget(self, action: #selector(btnNextClicked(_:)), for: .touchUpInside)
        vwBase.addSubview(btnNext)
        
        btnReplay = UIButton(type: .custom)
        btnReplay.frame = CGRect(x: 0, y: 0.7 * width, width: width, height: 0.3 * width)
        btnReplay.backgroundColor = .clear
        btnReplay.setImage(#imageLiteral(resourceName: "replay"), for: .normal)
        btnReplay.contentEdgeInsets = UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 0)
        btnReplay.addTarget(self, action: #selector(btnReplayClicked(_:)), for: .touchUpInside)
        vwBase.addSubview(btnReplay)
        
        btnPrev = UIButton(type: .custom)
        btnPrev.frame = CGRect(x: 0, y: 0, width: 0.3 * width, height: width)
        btnPrev.backgroundColor = .clear
        btnPrev.setImage(#imageLiteral(resourceName: "Prev"), for: .normal)
        btnPrev.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 17)
        btnPrev.addTarget(self, action: #selector(btnPrevClicked(_:)), for: .touchUpInside)
        vwBase.addSubview(btnPrev)

        if OrbUserDefaults.getTripStatus()
        {
            lblTripStatus.text = "END TRIP"
            lblTripStatus.textColor = .white
            btnTripStatus.setImage(#imageLiteral(resourceName: "End_Trip_Mark"), for: .normal)
            imgContorlsBg.image = #imageLiteral(resourceName: "TAB Controler_End_Trip")
        }
        else
        {
            lblTripStatus.text = "START TRIP"
            lblTripStatus.textColor = .black
            btnTripStatus.setImage(#imageLiteral(resourceName: "Trip_Dashboard"), for: .normal)
            imgContorlsBg.image = #imageLiteral(resourceName: "TAB Controler")
        }

        btnShufflePath.move(to: CGPoint(x: (0.3) * width, y: (0.3) * width))
        btnShufflePath.addLine(to: CGPoint(x: (0.14) * width, y: (0.15) * width))
        btnShufflePath.addQuadCurve(to: CGPoint(x: (0.85) * width, y: (0.14) * width), control: CGPoint(x: (0.5) * width, y: -(0.15)*width))
        btnShufflePath.addLine(to: CGPoint(x: (0.7) * width, y: (0.3) * width))
        btnShufflePath.addQuadCurve(to: CGPoint(x: (0.3) * width, y: (0.3) * width), control: CGPoint(x: (0.5) * width, y: (0.14) * width))

        let arcLayer1 = CAShapeLayer()
        arcLayer1.path = btnShufflePath
        arcLayer1.fillColor = circleColor.cgColor
        
        btnNextPath.move(to: CGPoint(x: 0.15 * width, y: 0.14 * width))
        btnNextPath.addQuadCurve(to: CGPoint(x: (0.16) * width, y: (0.85) * width), control: CGPoint(x: (1.5) * 0.3 * width, y: (0.5) * width))
        btnNextPath.addLine(to: CGPoint(x: (0) * width, y: (0.7) * width))
        btnNextPath.addQuadCurve(to: CGPoint(x: (0) * width, y: (0.3) * width), control: CGPoint(x: (0.16) * width, y: (0.5) * width))
        
        let arcLayer2 = CAShapeLayer()
        arcLayer2.path = btnNextPath
        arcLayer2.fillColor = circleColor.cgColor
        
        btnReplayPath.move(to: CGPoint(x: (0.86) * width, y: (0.15) * width))
        btnReplayPath.addQuadCurve(to: CGPoint(x: (0.14) * width, y: (0.15) * width), control: CGPoint(x: (0.5) * width, y: (1.5) * 0.3 * width))
        btnReplayPath.addLine(to: CGPoint(x: (0.3) * width, y: (0) * width))
        btnReplayPath.addQuadCurve(to: CGPoint(x: (0.7) * width, y: (0) * width), control: CGPoint(x: (0.5) * width, y: (0.16) * width))
        
        let arcLayer3 = CAShapeLayer()
        arcLayer3.path = btnReplayPath
        arcLayer3.fillColor = circleColor.cgColor
        
        btnPrevPath.move(to: CGPoint(x: (0.14) * width, y: (0.85) * width))
        btnPrevPath.addQuadCurve(to: CGPoint(x: (0.14) * width, y: (0.15) * width), control: CGPoint(x: (-0.15) * width, y: (0.5) * width))
        btnPrevPath.addLine(to: CGPoint(x: (0.3) * width, y: (0.3) * width))
        btnPrevPath.addQuadCurve(to: CGPoint(x: (0.3) * width, y: (0.7) * width), control: CGPoint(x: (0.14) * width, y: (0.5) * width))
        
        let arcLayer4 = CAShapeLayer()
        arcLayer4.path = btnPrevPath
        arcLayer4.fillColor = circleColor.cgColor
        
        btnShuffle.layer.insertSublayer(arcLayer1, at: 0)
        btnNext.layer.insertSublayer(arcLayer2, at: 0)
        btnReplay.layer.insertSublayer(arcLayer3, at: 0)
        btnPrev.layer.insertSublayer(arcLayer4, at: 0)
        btnShuffle.layer.masksToBounds = true
        btnNext.layer.masksToBounds = true
        btnReplay.layer.masksToBounds = true
        btnPrev.layer.masksToBounds = true
        
        vwTripStatus.bringSubview(toFront: vwBase)
    }
    @IBAction func btnShuffleClicked(_ sender: UIButton) {
        self.postActionToServerWith(strAction: "shuffle")
    }
    
    @IBAction func btnNextClicked(_ sender: UIButton) {
        self.postActionToServerWith(strAction: "next")
    }
    
    @IBAction func btnPrevClicked(_ sender: UIButton) {
        self.postActionToServerWith(strAction: "previous")
    }
    @IBAction func btnReplayClicked(_ sender: UIButton) {
        self.postActionToServerWith(strAction: "replay")
    }
    @IBAction func btnMuteClicked(_ sender: UIButton) {
        self.postActionToServerWith(strAction: "mute")
    }
    @IBAction func btnResetClicked(_ sender: UIButton) {
        self.postActionToServerWith(strAction: "tripreset")
    }
    @IBAction func btnRadioClicked(_ sender: UIButton) {
        self.postActionToServerWith(strAction: "radio")
    }
    @IBAction func btnVideoClicked(_ sender: UIButton) {
        self.postActionToServerWith(strAction: "content")
    }

    func postActionToServerWith(strAction : String)
    {
        app_delegate.showLoader(message: "Posting Action...")
        let layer = ServiceLayer()
        layer.sendActionWithType(actionType: strAction, successMessage: { (response) in
            DispatchQueue.main.async {
                app_delegate.removeloder()
                if strAction == "content"
                {
                    self.btnVideo.isSelected = true
                    self.btnRadio.isSelected = false
                    OrbUserDefaults.setVideoMode(object: true)
                }
                else if strAction == "radio"
                {
                    self.btnVideo.isSelected = false
                    self.btnRadio.isSelected = true
                    OrbUserDefaults.setVideoMode(object: false)
                }
                else if strAction == "mute"
                {
                    self.btnMute.isSelected = !self.btnMute.isSelected
                    OrbUserDefaults.setMuteStatus(object: self.btnMute.isSelected)
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
    @IBAction func btnStartTripClicked(_ sender: UIButton) {
        
        
        if OrbUserDefaults.getTripStatus()
        {
            let alert = UIAlertController(title: "Alert!", message:"Have you reached your Destination?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                app_delegate.showLoader(message: "Changing the trip status...")
                let layer = ServiceLayer()
                layer.setTripStatus(isStart: "1", location: "Location", isAirport: "0", isPool: "0", successMessage: { (response) in
                    DispatchQueue.main.async {
                        app_delegate.removeloder()
                        OrbUserDefaults.setTripStatus(object: false)
                        self.lblTripStatus.text = "START TRIP"
                        self.lblTripStatus.textColor = .black
                        self.btnTripStatus.setImage(#imageLiteral(resourceName: "Trip_Dashboard"), for: .normal)
                        self.imgContorlsBg.image = #imageLiteral(resourceName: "TAB Controler")
                    }
                    
                }) { (err) in
                    DispatchQueue.main.async {
                        app_delegate.removeloder()
                        let alert = UIAlertController(title: "Alert!", message:err as? String, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            if app_delegate.isServerReachable
            {
                let locVC = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
                self.navigationController?.pushViewController(locVC, animated: true)
            }
            else
            {
                let alert = UIAlertController(title: "Alert!", message:"Server not responding.\nPlease try after some time.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension UIButton
{
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if self == btnNext
        {
            if btnNextPath.contains(point) {
                return self;
            } else {
                return nil;
            }
            
        }
        else if self == btnPrev
        {
            if btnPrevPath.contains(point) {
                return self;
            } else {
                return nil;
            }
        }
        else if self == btnReplay
        {
            if btnReplayPath.contains(point) {
                return self;
            } else {
                return nil;
            }
        }
        else if self == btnShuffle
        {
            if btnShufflePath.contains(point) {
                return self;
            } else {
                return nil;
            }
        }
        else
        {
            let hitView = super.hitTest(point, with: event)

                return hitView;
        }
        
    }
    
}
