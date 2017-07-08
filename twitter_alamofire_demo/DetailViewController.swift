//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tyler Holloway on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import ActiveLabel



class DetailViewController: UIViewController {

    @IBOutlet weak var fromButtonToTop: NSLayoutConstraint!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var aliasNameLabel: UILabel!
    
    @IBOutlet weak var tweetText: ActiveLabel!
    
    @IBOutlet weak var amountOfLikes: UILabel!
    @IBOutlet weak var amountOfRetweets: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var mediaImageView: UIImageView!
    
//    weak var delegate: TweetCellDelegate?
    
   var tweet: Tweet!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        reloadData()
        
    }
    
    

    
    func reloadData() {
        // Text with clickable links
        tweetText.enabledTypes = [.mention, .hashtag, .url]
        tweetText.text = tweet.text
        tweetText.handleURLTap { (url) in
            UIApplication.shared.open(url)
        }
        tweetText.sizeToFit()
        
        let profpicURL = tweet.user.profilePictureUrl
        profileImageView.af_setImage(withURL: profpicURL!)
        
        //make profile picture circular
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        
        //tweetText.text = tweet.text
       
        aliasNameLabel.text = tweet.user.screenName
        userNameLabel.text = tweet.user.name
        
        amountOfLikes.text = String(tweet.favoriteCount)
        amountOfRetweets.text = String(tweet.retweetCount)
        
        //display media on detail view controller
        if let url = tweet.displayURL {
            mediaImageView.isHidden = false
            mediaImageView.af_setImage(withURL: url)
            //fromButtonToTop.constant = 200
        } else {
            mediaImageView.isHidden = true
            //fromButtonToTop.constant = 2
        }
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
