//
//  InboxViewController.swift
//  MailBoxDemo
//
//  Created by Ryan Sims on 9/25/14.
//  Copyright (c) 2014 Ryan Sims. All rights reserved.
//

import UIKit

class InboxViewController: UIViewController {
    @IBOutlet weak var topNavView: UIView!

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var helpImage: UIImageView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var actionsView: UIView!
    @IBOutlet weak var messageListImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.scrollView.contentSize = CGSizeMake(320, 400)
        self.scrollView.contentSize =
            CGSize(width: 320, height:
            self.helpImage.frame.size.height +
            self.searchImage.frame.size.height +
            self.messageImage.frame.size.height +
            self.messageListImage.frame.size.height
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
