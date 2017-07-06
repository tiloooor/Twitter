//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage


class TweetCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    
    

    
    var tweet: Tweet! {
        didSet {
            usernameLabel.text = tweet.user.name
            aliasLabel.text = tweet.user.screenName
            timeStampLabel.text = tweet.createdAtString
            
            // Set the profile picture
            let profpicURL = tweet.user.profilePictureUrl
            profileImageView.af_setImage(withURL: profpicURL!)
            
            // Check if Tweet is a retweet
            if let ogTweet = tweet.retweetedStatus {
                print("I'm a retweet! ")
                reloadData(with: ogTweet)
            } else {
                print("This is an original tweet!")
                reloadData(with: tweet)
            }
        }
    }
    
    func reloadData(with tweet: Tweet) {
        tweetTextLabel.text = tweet.text
        likeCount.text = String(tweet.favoriteCount)
        retweetLabel.text = String(tweet.retweetCount)
        
        if tweet.favorited {
            likeButton.isSelected = true
        } else {
            likeButton.isSelected = false
        }
        
        // retweet button
        if tweet.retweeted {
            retweetButton.isSelected = true
        } else {
            retweetButton.isSelected = false
        }
        
    }
    
    func makeRetweet(_ tweet: Tweet) {
        // Update model
        tweet.retweeted = true
        tweet.retweetCount = tweet.favoriteCount + 1
        // Update UI
        reloadData(with: tweet)
        // Update API
        APIManager.shared.retweetTweet(with: tweet, completion: { (tweet: Tweet?, error: Error?) in
            if let tweet = tweet {
                self.tweet = tweet
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        })
    }
    
    
        
        
//        if retweetButton.isSelected {
//            if let ogTweet = tweet.retweetedStatus {
//                makeRetweet(ogTweet)
//            } else {
//                makeRetweet(tweet)
//            }
//        } else {
//            if let ogTweet = tweet.retweetedStatus {
//                makeRetweet(ogTweet)
//            } else {
//                makeRetweet(tweet)
//            }
//        }
        
        

    
    func unfavorite(_ tweet: Tweet) {
        // Update model
        tweet.favorited = false
        tweet.favoriteCount = tweet.favoriteCount - 1
        // Update UI
        reloadData(with: tweet)
        // Update API
        APIManager.shared.unfavorite(tweet, completion: { (tweet, error) in
            if let error = error {
                print("Error unfavoriting: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successful un-favorite: \(tweet.text)")
            }
        })
    }
    
    func favorite(_ tweet: Tweet) {
        // Update model
        tweet.favorited = true
        tweet.favoriteCount = tweet.favoriteCount + 1
        // Update UI
        reloadData(with: tweet)
        // Update API
        APIManager.shared.favorite(tweet, completion: { (tweet, error) in
            if let error = error {
                print("Error unfavoriting: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successful favorite: \(tweet.text)")
            }
        })
    }

    
    @IBAction func pressLike(_ sender: Any) {
        if likeButton.isSelected {
            if let ogTweet = tweet.retweetedStatus {
                unfavorite(ogTweet)
            } else {
                unfavorite(tweet)
            }
        } else {
            if let ogTweet = tweet.retweetedStatus {
                favorite(ogTweet)
            } else {
                favorite(tweet)
            }
        }
    }
    
    
    
    //    @IBAction func pressLike(_ sender: Any) {
    //        if likeButton.isSelected {
    //            likeButton.isSelected = false
    //            tweet.favorited = false
    //            tweet.favoriteCount! -= 1
    //            self.likeCount.text = String(tweet.favoriteCount!)
    //            print("liked")
    //        } else {
    //            likeButton.isSelected = true
    //            tweet.favorited = true
    //            tweet.favoriteCount! += 1
    //            self.likeCount.text = String(tweet.favoriteCount!)
    //            print("unliked")
    //
    //            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
    //                if let  error = error {
    //                    print("Error favoriting tweet: \(error.localizedDescription)")
    //                } else if let tweet = tweet {
    //                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
    //                }
    //            }
    //
    //        }
    //
    //    }
    //
    
    //        if likeButton.isSelected {
    //            likeButton.isSelected = false
    //            tweet.favorited = false
    //            tweet.favoriteCount! -= 1
    //            self.likeCount.text = String(tweet.favoriteCount!)
    //        } else {
    //            likeButton.isSelected = true
    //            tweet.favorited = true
    //            tweet.favoriteCount += 1
    //            self.likeCount.text = String(tweet.favoriteCount!)
    //
    ////            APIManager.shared.likeTweet(with: tweet, completion: { (tweet: Tweet?, error: Error?) in
    ////                if let tweet = tweet {
    ////                    self.tweet = tweet
    ////                } else if let error = error {
    ////                    print("Error getting home timeline: " + error.localizedDescription)
    ////                }
    ////
    ////            })
    //
    
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
