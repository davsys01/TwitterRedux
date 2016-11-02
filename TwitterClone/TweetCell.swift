//
//  TweetCell.swift
//  TwitterClone
//
//  Created by David Bocardo on 10/31/16.
//  Copyright © 2016 David Bocardo. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    
    var tweet: Tweet? {
        didSet {
            tweetText.text = tweet?.text
            if let screen = tweet?.userScreenName {
                screenName.text = "@\(screen)"
            }
//            screenName.text = "@\(tweet?.userScreenName)"
            userName.text = tweet?.userName

            if let timeStampDate = tweet?.timeStamp {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d"
                timeStamp.text = formatter.string(from: timeStampDate)
            }
            
            if let profileImage = tweet?.profilePicture {
                profilePicture.setImageWith(URL(string: profileImage)!)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        profilePicture.layer.cornerRadius = 5
        profilePicture.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
