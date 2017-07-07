//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tyler Holloway on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    // MARK: Properties
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var aliasNameLabel: UILabel!
    @IBOutlet weak var dateStamp: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var retweetNum: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    

    
     var tweet: Tweet!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetText.text = tweet.text 
        
        //let url = URL(string: tweet.user.profilePicutreUrl)!
        //profilePictureImageVIew.af_setImage(withURL: url)

        // Do any additional setup after loading the view.
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
