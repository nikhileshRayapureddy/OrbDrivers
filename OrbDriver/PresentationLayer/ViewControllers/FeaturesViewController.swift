//
//  FeaturesViewController.swift
//  OrbDriver
//
//  Created by Nikhilesh on 20/12/17.
//  Copyright © 2017 Nikhilesh. All rights reserved.
//

import UIKit

class FeaturesViewController: UIViewController {

    @IBOutlet weak var scrlVwFeatures: UIScrollView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var constPageControlWidth: NSLayoutConstraint!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for i in 0...3
        {
            let lblTitle = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width * CGFloat(i), y: 0, width: UIScreen.main.bounds.size.width, height: 80))
            lblTitle.backgroundColor = .clear
            lblTitle.center = CGPoint(x:lblTitle.center.x, y: scrlVwFeatures.center.y-200)
            lblTitle.font = UIFont(name: "Roboto-Light", size: 28)
            lblTitle.textColor = .black
            lblTitle.textAlignment = .center
            lblTitle.numberOfLines = 2
            lblTitle.lineBreakMode = .byWordWrapping

            scrlVwFeatures.addSubview(lblTitle)

            //let jeremyGif = UIImage.gifImageWithName("radio_playing")
            let imageView = UIImageView(frame: CGRect(x: UIScreen.main.bounds.size.width * CGFloat(i), y: 0, width: UIScreen.main.bounds.size.width, height: 276) )
            imageView.center = CGPoint(x:imageView.center.x, y: scrlVwFeatures.center.y)
            imageView.contentMode = .scaleAspectFit
//            imageView.backgroundColor  = .red
            scrlVwFeatures.addSubview(imageView)

            let lblContent = UILabel()
            lblContent.backgroundColor = .clear
            lblContent.font = UIFont(name: "Roboto-Light", size: 17)
            lblContent.textColor = .black
            lblContent.numberOfLines = 0
            lblContent.lineBreakMode = .byWordWrapping
            lblContent.textAlignment = .center
            scrlVwFeatures.addSubview(lblContent)
            
            if i == 0
            {
                lblContent.frame = CGRect(x: UIScreen.main.bounds.size.width * CGFloat(i) + 40, y: scrlVwFeatures.frame.size.height - 80, width: UIScreen.main.bounds.size.width - 80, height: 40)
                lblTitle.frame = CGRect(x: UIScreen.main.bounds.size.width * CGFloat(i), y: 40, width: UIScreen.main.bounds.size.width, height: 80)
                lblTitle.text = "Welcome\nto"
                imageView.image = #imageLiteral(resourceName: "Screen_01")
                imageView.center = CGPoint(x:imageView.center.x, y: scrlVwFeatures.center.y - 10)
                lblContent.text = "Thank you for registering with us."
            }
            else if i == 1
            {
                lblContent.frame = CGRect(x: UIScreen.main.bounds.size.width * CGFloat(i) + 35, y: scrlVwFeatures.frame.size.height - 80, width: UIScreen.main.bounds.size.width - 70, height: 40)
                lblTitle.text = "Track Your Progress"
                imageView.image = #imageLiteral(resourceName: "Screen_02")
                lblContent.text = "Keep tabs on your progress over time with our trip tracker."
            }
            else if i == 2
            {
                lblContent.frame = CGRect(x: UIScreen.main.bounds.size.width * CGFloat(i) + 35, y: scrlVwFeatures.frame.size.height - 70, width: UIScreen.main.bounds.size.width - 70, height: 40)
                lblTitle.text = "Access Remotely"
                imageView.image = #imageLiteral(resourceName: "Screen_03")
                lblContent.text = "Use this App to remotely control the Orb tablet."
            }

            
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrlVwFeatures.contentSize = CGSize(width: UIScreen.main.bounds.size.width * 3, height: scrlVwFeatures.frame.size.height)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func btnNextClicked(_ sender: UIButton) {
        var pageNo = scrlVwFeatures.contentOffset.x/UIScreen.main.bounds.size.width
        pageNo = pageNo + 1
        if pageNo == 2
        {
            sender.setTitle("DONE", for: .normal)
            pageControl.currentPage = Int(pageNo)
            scrlVwFeatures.setContentOffset(CGPoint(x: pageNo * UIScreen.main.bounds.size.width, y: 0), animated: true)

        }
        else if pageNo > 2
        {
            self.btnSkipClicked(UIButton())
        }
        else
        {
            pageControl.currentPage = Int(pageNo)
            scrlVwFeatures.setContentOffset(CGPoint(x: pageNo * UIScreen.main.bounds.size.width, y: 0), animated: true)
            sender.setTitle("NEXT", for: .normal)
            
        }
    }
    @IBAction func btnSkipClicked(_ sender: UIButton) {
        let locVC = UIStoryboard (name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
        self.navigationController?.pushViewController(locVC, animated: true)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension FeaturesViewController : UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNo = scrollView.contentOffset.x/UIScreen.main.bounds.size.width
        pageControl.currentPage = Int(pageNo)
        print("pageNo : \(pageNo)")
        print("scrollView.contentOffset.x : \(scrollView.contentOffset.x)")
        if pageNo >= 2
        {
            btnNext.setTitle("DONE", for: .normal)
        }
        else
        {
            btnNext.setTitle("NEXT", for: .normal)
            
        }


    }
}
