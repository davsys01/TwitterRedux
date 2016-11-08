//
//  TweetsViewController.swift
//  TwitterClone
//
//  Created by David Bocardo on 10/31/16.
//  Copyright © 2016 David Bocardo. All rights reserved.
//

import UIKit
import FTIndicator

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate, TweetCellProtocol {
    
    var tweets: [Tweet]?
    
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    @IBAction func onComposeButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let composeViewController = storyboard.instantiateViewController(withIdentifier: "ComposeViewController") as! ComposeViewController
        composeViewController.delegate = self
        self.present(composeViewController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 58
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.getTweetsData), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        getTweetsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    func onTweetSucceeded(tweet: Tweet) {
        self.tweets?.insert(tweet, at: 0)
        getTweetsData()
    }
    
    func getTweetsData() {
//        FTIndicator.showProgressWithmessage("Loading Tweets...")
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let tweet = (tweets?[indexPath.row])! as Tweet

        cell.tweet = tweet
        cell.delegate = self

        return cell
    }
    
    func loadViewController(controller: ProfileViewController!) {
        self.willMove(toParentViewController: controller)
        self.show(controller, sender: self)
        //self.present(controller, animated: true, completion: nil)
        self.didMove(toParentViewController: controller)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTweet" {
            let tweetVC = segue.destination as! TweetViewController
            
            if let indexPath = tableView.indexPath(for: sender as! TweetCell) {
                let tweet = self.tweets![indexPath.row]
                tweetVC.tweet = tweet
            }
        }
    }
}
