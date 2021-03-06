//
//  User.swift
//  TwitterClone
//
//  Created by David Bocardo on 10/30/16.
//  Copyright © 2016 David Bocardo. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    var uid: String?
    var name: String?
    var screenName: String?
    var profileUrl: URL?
    var tagline: String?
    var followersCount: Int64?
    var statusesCount: Int64?
    var favoritesCount: Int64?
    var profileBannerUrl: URL?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        uid = dictionary["id_str"] as? String
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        tagline = dictionary["description"] as? String
        followersCount = dictionary["followers_count"] as? Int64
        statusesCount = dictionary["statuses_count"] as? Int64
        favoritesCount = dictionary["favourites_count"] as? Int64
        let profileBannerUrlString = dictionary["profile_banner_url"] as? String
        if let profileBannerUrlString = profileBannerUrlString {
            profileBannerUrl = URL(string: profileBannerUrlString)
        }
    }
    
    static var _currentUser: String?
    
    class var currentUser: String? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                _currentUser = defaults.string(forKey: "currentUser")
            }
            
            return _currentUser
        }
        set (user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user {
                defaults.set(user, forKey: "currentUser")
            } else {
                defaults.set(nil, forKey: "currentUser")
            }
            defaults.synchronize()
        }
    }
}
