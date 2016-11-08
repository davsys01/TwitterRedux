//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by David Bocardo on 11/6/16.
//  Copyright © 2016 David Bocardo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    
    var currentUser: User!
    var showCurrentUser: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 25
        profileImage.clipsToBounds = true

        showProfile()
    }
    
    func showProfile() {
        if showCurrentUser == true {
            TwitterClient.sharedInstance?.currentAccount(success: { (user: User) in
                self.currentUser = user
                if let bannerUrl = self.currentUser.profileBannerUrl {
                    self.bannerImage.setImageWith(bannerUrl)
                }
                if let profileUrl = self.currentUser.profileUrl {
                    self.profileImage.setImageWith(profileUrl)
                }
                self.userNameLabel.text = self.currentUser.name
                self.screenNameLabel.text = "@\(self.currentUser.screenName!)"
                self.taglineLabel.text = self.currentUser.tagline
                self.followersCountLabel.text = "\(self.currentUser.followersCount!)"
                self.tweetsCountLabel.text = "\(self.currentUser.statusesCount!)"
            }, failure: { (error: Error) in
                print("Error = \(error.localizedDescription)")
            })
        } else {
            if let bannerUrl = currentUser.profileBannerUrl {
                bannerImage.setImageWith(bannerUrl)
            }
            if let profileUrl = currentUser.profileUrl {
                profileImage.setImageWith(profileUrl)
            }
            userNameLabel.text = currentUser.name
            screenNameLabel.text = "@\(currentUser.screenName!)"
            taglineLabel.text = currentUser.tagline
            followersCountLabel.text = "\(currentUser.followersCount!)"
            tweetsCountLabel.text = "\(currentUser.statusesCount!)"
        }
    }
    
    @IBAction func onHamburgerPressed(_ sender: Any) {
        
    }
}
