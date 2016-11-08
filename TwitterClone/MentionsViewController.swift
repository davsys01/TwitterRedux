//
//  MentionsViewController.swift
//  TwitterClone
//
//  Created by David Bocardo on 11/6/16.
//  Copyright © 2016 David Bocardo. All rights reserved.
//

import UIKit
import FTIndicator

class MentionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet]?
    
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 58
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.getMentionsData), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        getMentionsData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MentionCell", for: indexPath) as! MentionCell
        let tweet = (tweets?[indexPath.row])! as Tweet
        
        cell.tweet = tweet
        
        return cell
    }
    
    func getMentionsData() {
//        FTIndicator.showProgressWithmessage("Loading Mentions...")
        TwitterClient.sharedInstance?.mentionsTimeline(success: { (tweets: [Tweet]) in
//            FTIndicator.dismissProgress()
            self.refreshControl.endRefreshing()
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) in
//            FTIndicator.dismissProgress()
            self.refreshControl.endRefreshing()
            print("Error = \(error.localizedDescription)")
        })
    }
}
