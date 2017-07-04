//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

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
    
    var favoriteCount: Int?
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            favoriteCount = tweet.favoriteCount!
        }
    }
    
    
    @IBAction func pressRetweet(_ sender: Any) {
        if retweetButton.isSelected {
            retweetButton.isSelected = false
        } else {
            retweetButton.isSelected = true
        }
    }
    
    @IBAction func pressLike(_ sender: Any) {
        tweet.favoriteCount = 0
        if likeButton.isSelected {
            likeButton.isSelected = false
            self.favoriteCount! -= 1
            self.likeCount.text = String(self.favoriteCount!)
        } else {
            likeButton.isSelected = true
            self.favoriteCount! += 1
            self.likeCount.text = String(self.favoriteCount!)
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
