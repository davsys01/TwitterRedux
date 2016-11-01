//
//  ComposeViewController.swift
//  TwitterClone
//
//  Created by David Bocardo on 10/31/16.
//  Copyright © 2016 David Bocardo. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate {
    func onTweetSucceeded(tweet: Tweet)
}

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var tweetText: UITextField!
    @IBOutlet weak var lengthLabel: UILabel!
    
    let tweetLength: Int = 140
    var delegate: ComposeViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetText.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func updateCount(_ sender: Any) {
        let length = tweetText.text?.characters.count
        lengthLabel.text = "\(tweetLength - length!)"
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func onTweetButton(_ sender: Any) {
        let tweetDictionary = ["text":tweetText.text!] as NSDictionary
        let tweet = Tweet(dictionary: tweetDictionary)
        
        TwitterClient.sharedInstance?.composeTweet(tweet: tweet, success: { (tweet: Tweet) in
            self.tweetText.resignFirstResponder()
            self.delegate.onTweetSucceeded(tweet: tweet)
            self.dismiss(animated: true, completion: nil)
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        tweetText.resignFirstResponder()
        dismiss(animated: true, completion: nil)
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
