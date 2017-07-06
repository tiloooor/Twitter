//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tyler Holloway on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
//import RSKPlaceholderTextView


protocol ComposeViewControllerDelegate: class {
    func didPostTweet(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    // MARK: Properties

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var sendTweetButton: UIButton!
    
    
    
    weak var delegate: ComposeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate the profile picture 
        let profilepicURL = User.current?.profilePictureUrl
        profileImageView.af_setImage(withURL: profilepicURL!)

        
        //tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapPost(_ sender: Any) {
        let tweetText = tweetTextView.text
        
        APIManager.shared.composeTweet(with: tweetText!) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.didPostTweet(post: tweet)
                print("Compose Tweet Success!")
                self.dismiss(animated: true, completion: nil)
            }
        }
        
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
