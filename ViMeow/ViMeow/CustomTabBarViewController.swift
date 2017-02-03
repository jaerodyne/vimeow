//
//  CustomTabBarViewController.swift
//  ViMeow
//
//  Created by Jillian Somera on 2/2/17.
//  Copyright © 2017 Jillian Somera. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
//    let animal = AnimalModel()
//    var searchText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self

        if let items = self.tabBar.items {
            
            //Get the height of the tab bar
            
            let height = self.tabBar.bounds.height
            
            //Calculate the size of the items
            
            let numItems = CGFloat(items.count)
            let itemSize = CGSize(
                width: tabBar.frame.width / numItems,
                height: tabBar.frame.height)
            
            for (index, _) in items.enumerated() {
                
                //We don't want a separator on the left of the first item.
                
                if index > 0 {
                    
                    //Xposition of the item
                    
                    let xPosition = itemSize.width * CGFloat(index)
                    
                    /* Create UI view at the Xposition,
                     with a width of 0.5 and height equal
                     to the tab bar height, and give the
                     view a background color
                     */
                    let separator = UIView(frame: CGRect(
                        x: xPosition, y: 0, width: 0.5, height: height))
                    separator.backgroundColor = UIColor.gray
                    tabBar.insertSubview(separator, at: 1)
                }
            }
        }
    }

//    func tabBarController(_ tabBarController: UITabBarController,
//                          didSelect viewController: UIViewController){
    
//        if tabBarController.selectedIndex == 0 {
//            animal.getVideos(searchText: "Cats")
//            print("We're number 0!")
//        } else if tabBarController.selectedIndex == 1 {
//            animal.getVideos(searchText: "Dogs")
//            print("We're number 1!")
//        } else {
//            print("We're whatever number you want us to be!")
//        }
//        print("We selected something")
//    }

}
