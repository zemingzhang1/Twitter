//
//  TweetViewController.swift
//  Twitter
//
//  Created by Ze Ming Zhang on 9/29/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textViewCount: UITextView!
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self
        textViewCount.text = "Tweet character count is: 7\n" + "Total character limit is 280)"
        
        // Do any additional setup after loading the view.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        // Set the max character limit
        let characterLimit = 280

        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)
        
        let newTextTrimmed = newText.trimmingCharacters(in:.whitespacesAndNewlines)

        // TODO: Update Character Count Label
        textViewCount.text = "Tweet character count is: " + String(newTextTrimmed.count) + "\n" + "Total character limit is \(String(characterLimit))"
        
        // The new text should be allowed? True/False
        return newTextTrimmed.count < characterLimit
    }
    
    @IBAction func Tweet(_ sender: Any) {
        if(!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
                
            }, failure: {(error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
