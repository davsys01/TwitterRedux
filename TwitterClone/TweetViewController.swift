//
//  TweetViewController.swift
//  TwitterClone
//
//  Created by David Bocardo on 11/1/16.
//  Copyright © 2016 David Bocardo. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    var tweet: Tweet!
    var likeFlag: Bool = true
    var rtFlag: Bool = true
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var rtButton: UIButton!
    @IBOutlet weak var rtCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showTweet()
    }
    
    @IBAction func onRTButton(_ sender: Any) {
        TwitterClient.sharedInstance?.retweet(tweet: self.tweet, success: { (tweet: Tweet) in
            let imageName: String = self.rtFlag ? "FilledRTIcon" : "EmptyRTIcon"
            let rtImage = UIImage(named: imageName)
            self.rtButton.setImage(rtImage, for: UIControlState.normal)
            self.rtFlag = !self.rtFlag
            
            let currentRTCount = Int(self.rtCount.text!)! + 1
            self.rtCount.text = "\(currentRTCount)"
            
        }, failure: { (error: Error) in
            print("\(error.localizedDescription)")
        })
    }
    
    @IBAction func onLikeButton(_ sender: Any) {
        TwitterClient.sharedInstance?.favorite(tweet: self.tweet, success: { (tweet: Tweet) in
            let imageName: String = self.likeFlag ? "FilledHeartIcon" : "EmptyHeartIcon"
            let heartImage = UIImage(named: imageName)
            self.likeButton.setImage(heartImage, for: UIControlState.normal)
            self.likeFlag = !self.likeFlag

            let currentLikeCount = Int(self.likeCount.text!)! + 1
            self.likeCount.text = "\(currentLikeCount)"
        }, failure: { (error: Error) in
            print("\(error.localizedDescription)")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showTweet() {
        tweetText.text = tweet?.text
        if let screen = tweet?.userScreenName {
            screenName.text = "@\(screen)"
        }
        userName.text = tweet?.userName
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        timeStamp.text = formatter.string(from: (tweet?.timeStamp)!)
        
        if let profileImage = tweet?.profilePicture {
            profilePicture.setImageWith(URL(string: profileImage)!)
        }
        rtCount.text = "\(tweet.retweetCount)"
        likeCount.text = "\(tweet.favoriteCount)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
