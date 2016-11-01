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
            screenName.text = tweet?.userScreenName
            userName.text = tweet?.userName
            timeStamp.text = ""
            profilePicture.image = nil
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
