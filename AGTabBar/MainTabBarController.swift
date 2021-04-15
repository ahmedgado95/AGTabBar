//
//  MainTabBarController.swift
//  AGTabBar
//
//  Created by ahmed gado on 15/04/2021.
//  Copyright © 2021 ahmed gado. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController ,UITabBarControllerDelegate{


    var indexSelected = 0
    static var shared : MainTabBarController?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setUpViewControllers()
        setupMiddleButton()

        if MainTabBarController.shared == nil {
            MainTabBarController.shared = self
        }
        
    }

  
    // TabBarButton – Setup Middle Button
    func setupMiddleButton() {
        
        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-33, y: -33, width: 66, height: 66))
        
        
        //middleBtn.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        //STYLE THE BUTTON YOUR OWN WAY
        
        middleBtn.setImage(UIImage(named: "ab_offers"), for: .normal)
        middleBtn.backgroundColor = .white
        middleBtn.layer.cornerRadius = (middleBtn.frame.width / 2)
        middleBtn.layer.masksToBounds = false

        //add to the tabbar and add click event
        self.tabBar.addSubview(middleBtn)
        
        
        middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    // Menu Button Touch Action
    @objc func menuButtonAction(sender: UIButton) {
        //self.selectedIndex = 2   //to select the middle tab. use "1" if you have only 3 tabs.
   
        
        let cartVc = Storyboard.Main.instantiate(BinVc.self)
        
        let nav = UINavigationController(rootViewController: cartVc)
        nav.setNavigationBarHidden(true, animated: false)
        present(nav, animated: true, completion: nil)

    }
    
    
    func setUpViewControllers () {
        let selectedColor = hexStringToUIColor(hex: "13679B")
   
        let homeVc = Storyboard.Main.instantiate(HomeVc.self)
        let homeNav = UINavigationController(rootViewController: homeVc)
        
        homeVc.view.backgroundColor = .red
        homeNav.title = "Home"
        homeNav.tabBarItem.image = UIImage(named: "ab_home")
        homeNav.tabBarItem.selectedImage = UIImage(named: "ab_home")?.withRenderingMode(.alwaysOriginal)
        homeNav.setNavigationBarHidden(true, animated: false)
        
        
        let myOrdersVc = Storyboard.Main.instantiate(MyOrderVc.self)
        myOrdersVc.view.backgroundColor = .green
        let myOrdersNav = UINavigationController(rootViewController: myOrdersVc)
        myOrdersNav.title = "Order"
        myOrdersVc.title = "Order"
        myOrdersNav.tabBarItem.image = UIImage(named: "ab_categories")
        myOrdersNav.tabBarItem.selectedImage = UIImage(named: "ab_categories")?.withRenderingMode(.alwaysOriginal)
        myOrdersNav.setNavigationBarHidden(true, animated: false)

        let mysettingVc = Storyboard.Main.instantiate(SettingVC.self)
        mysettingVc.view.backgroundColor = .purple
        let mySettingNav = UINavigationController(rootViewController: mysettingVc)
        mySettingNav.title = "Setting"
        mysettingVc.title = "Seting"
        mySettingNav.tabBarItem.image = UIImage(named: "ab_settings")
        mySettingNav.tabBarItem.selectedImage = UIImage(named: "ab_settings")?.withRenderingMode(.alwaysOriginal)
        mySettingNav.setNavigationBarHidden(true, animated: false)
        
        let myAboutVc = Storyboard.Main.instantiate(AboutVC.self)
        myAboutVc.view.backgroundColor = .blue
        let myAboutNav = UINavigationController(rootViewController: myAboutVc)
        myAboutNav.title = "About"
        myAboutVc.title = "About"
        myAboutNav.tabBarItem.image = UIImage(named: "ab_cart")
        myAboutNav.tabBarItem.selectedImage = UIImage(named: "ab_cart")?.withRenderingMode(.alwaysOriginal)
        myAboutNav.setNavigationBarHidden(true, animated: false)
        
        
        
        let emptyNav = UINavigationController()
        emptyNav.tabBarItem.isEnabled = false
        
        
        
        
        viewControllers = [homeNav ,mySettingNav ,emptyNav, myOrdersNav, myAboutNav]
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
    }
    
    
    
 
    
    

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
