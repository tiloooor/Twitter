//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import DateToolsSwift
import ActiveLabel



protocol TweetCellDelegate: class {
    // Add required methods the delegate needs to implement
    func tweetCell(_ tweetCell: TweetCell, didTap user: User)
}



class TweetCell: UITableViewCell {
    
    // MARK: Properties
    

    @IBOutlet weak var tweetTextLabel: ActiveLabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var fromButtonToTop: NSLayoutConstraint!
    
    weak var delegate: TweetCellDelegate?
 
    
    var tweet: Tweet! {
        didSet {
            
            //Active label
            tweetTextLabel.enabledTypes = [.mention, .hashtag, .url]
            tweetTextLabel.text = tweet.text
            tweetTextLabel.handleURLTap { (url) in
                UIApplication.shared.open(url)
            }
            profileImageView.layer.cornerRadius = 8; // this value vary as per your desire
            profileImageView.clipsToBounds = true;
            
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
            //if there's image media in the tweet, display it
            if let url = tweet.displayURL {
                mediaImageView.isHidden = false
                mediaImageView.af_setImage(withURL: url)
                fromButtonToTop.constant = 400
            }
                //if there's no image media, hide the image view and shrink the constraint
            else {
                mediaImageView.isHidden = true
                fromButtonToTop.constant = 2
            }
            
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
                print("Successful retweet: \(tweet.text)")
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        })
    }
    
    
    func unRetweet(_ tweet: Tweet) {
        // Update model
        tweet.retweeted = false
        tweet.retweetCount = tweet.favoriteCount - 1
        // Update UI
        reloadData(with: tweet)
        // Update API
        APIManager.shared.unretweet(tweet, completion: { (tweet: Tweet?, error: Error?) in
            if let tweet = tweet {
                self.tweet = tweet
                print("Successful retweet: \(tweet.text)")
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        })
        
     }
    
    
    
    

    
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
    
    
/****************Actual*******************/
    
//    func unfavorite(_ tweet: Tweet) {
//        // Update model
//        tweet.favorited = false
//        tweet.favoriteCount = tweet.favoriteCount - 1
//        // Update UI
//        reloadData(with: tweet)
//        // Update API
//        APIManager.shared.unfavorite(tweet, completion: { (tweet, error) in
//            if let error = error {
//                print("Error unfavoriting: \(error.localizedDescription)")
//            } else if let tweet = tweet {
//                print("Successful un-favorite: \(tweet.text)")
//            }
//        })
//
//    }
//    
//    
//    func favorite(_ tweet: Tweet) {
//        // Update model
//        tweet.favorited = true
//        tweet.favoriteCount = tweet.favoriteCount + 1
//        // Update UI
//        reloadData(with: tweet)
//        // Update API
//        APIManager.shared.favorite(tweet, completion: { (tweet, error) in
//            if let error = error {
//                print("Error unfavoriting: \(error.localizedDescription)")
//            } else if let tweet = tweet {
//                print("Successful favorite: \(tweet.text)")
//            }
//        })
//        
//    }
//
//    
//    @IBAction func pressLike(_ sender: Any) {
//        if likeButton.isSelected {
//            if let ogTweet = tweet.retweetedStatus {
//                unfavorite(ogTweet)
//            } else {
//                unfavorite(tweet)
//            }
//        } else {
//            if let ogTweet = tweet.retweetedStatus {
//                favorite(ogTweet)
//            } else {
//                favorite(tweet)
//            }
//        }
//    }
//    
    

    
    @IBAction func pressRetweet(_ sender: Any) {
        if retweetButton.isSelected {
            if let ogTweet = tweet.retweetedStatus {
                unRetweet(ogTweet)
            } else {
                unRetweet(tweet)
            }
        } else {
            if let ogTweet = tweet.retweetedStatus {
                makeRetweet(ogTweet)
            } else {
                makeRetweet(tweet)
            }
        }
    }
    


    
}
