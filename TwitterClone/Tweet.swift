//
//  Tweet.swift
//  TwitterClone
//
//  Created by David Bocardo on 10/30/16.
//  Copyright © 2016 David Bocardo. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var idStr: String?
    var text: String?
    var timeStamp: Date?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var profilePicture: String?
    var userName: String?
    var userScreenName: String?
    var replyToId: String?
    
    init(dictionary: NSDictionary) {
        idStr = dictionary["id_str"] as? String
        text = dictionary["text"] as? String
        
        let timeStampString = dictionary["created_at"] as? String
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timeStampString)
        }
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0
        if let userDictionary = dictionary["user"] as? NSDictionary {
            userName = userDictionary["name"] as? String
            userScreenName = userDictionary["screen_name"] as? String
            profilePicture = userDictionary["profile_image_url_https"] as? String
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
}
