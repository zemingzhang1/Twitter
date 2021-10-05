//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Ze Ming Zhang on 9/27/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit


class TweetCellTableViewCell: UITableViewCell {
    var retweeted:Bool = false
    var tweetID:Int = -1
    var favorited: Bool = false
    
    @IBOutlet weak var timeAgoLabel: UILabel!

    @IBOutlet weak var profileImageview: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBAction func retweetAct(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetID, Success: {
            self.setRetweeted(_isRetweeted: true)
            print("retweeted success")
        },
        failure: { (error) in
            print("Error in retweeting\(error)")
        })
    }
    

    
    @IBAction func favAct(_ sender: Any) {
        let favoriteIt = !favorited
        if(favoriteIt){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetID, success: {
                self.setFavorited(true)
            },
            failure: { (error) in
            print("Favorite did not succeed:\(error)")
            })
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetID, success: {
                self.setFavorited(false)
            },
            failure: { (error) in
            print("Unfavorite did not succeed:\(error)")
            })
        }
    }
    
    func setFavorited(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for:UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage(named: "favor-icon"), for:UIControl.State.normal)
        }
    }
    
    func setRetweeted(_isRetweeted:Bool){
        if (_isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for:UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for:UIControl.State.normal)
            retweetButton.isEnabled = true
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
