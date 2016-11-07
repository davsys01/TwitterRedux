//
//  MenuViewController.swift
//  TwitterClone
//
//  Created by David Bocardo on 11/6/16.
//  Copyright © 2016 David Bocardo. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var menuOptionsArray = ["Profile", "Home", "Mentions", "Log"]
    var menuColorsArray = [UIColor(colorLiteralRed: 0.27, green: 0.62, blue: 0.93, alpha: 1.0),
                           UIColor(colorLiteralRed: 0.45, green: 0.87, blue: 0.76, alpha: 1.0),
                           UIColor(colorLiteralRed: 1.00, green: 0.50, blue: 0.00, alpha: 1.0),
                           UIColor(colorLiteralRed: 0.40, green: 1.00, blue: 0.40, alpha: 1.0)]
    
    private var profileViewController: UIViewController!
    private var homeViewController: UIViewController!
    private var mentionsViewController: UIViewController!
    private var loginViewController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    
    var hamburgerViewController: HamburgerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.white
        tableView.rowHeight = 60
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController")
        homeViewController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController")
        mentionsViewController = storyboard.instantiateViewController(withIdentifier: "MentionsNavigationController")
        loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        
        viewControllers.append(profileViewController)
        viewControllers.append(homeViewController)
        viewControllers.append(mentionsViewController)
//        viewControllers.append(loginViewController)
        
        if User.currentUser != nil {
            hamburgerViewController.contentViewController = homeViewController
        } else {
            hamburgerViewController.contentViewController = loginViewController
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        //return menuOptionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        var imageName = menuOptionsArray[indexPath.row]
        let color = menuColorsArray[indexPath.row]
        
        if imageName == "Log" {
            imageName = User.currentUser != nil ? "LogOut" : "LogIn"
        }
        
        cell.imageView?.image = UIImage(imageLiteralResourceName: imageName)
        cell.backgroundColor = color
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
    }
}
