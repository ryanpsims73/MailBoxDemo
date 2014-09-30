//
//  MailboxViewController.swift
//  MailBoxDemo
//
//  Created by Ryan Sims on 9/25/14.
//  Copyright (c) 2014 Ryan Sims. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var mailBoxView: UIView!
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var navImage: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var searchBoxImage: UIImageView!

    @IBOutlet weak var messageImage: UIImageView!
    
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var actionsView: UIView!
    
    @IBOutlet weak var rightIconView: UIView!
    @IBOutlet weak var laterIconImage: UIImageView!
    @IBOutlet weak var listIconImage: UIImageView!

    @IBOutlet weak var leftIconView: UIView!
    @IBOutlet weak var deleteIconImage: UIImageView!
    @IBOutlet weak var archiveIconImage: UIImageView!
    
    @IBOutlet weak var modalMenuView: UIView!
    @IBOutlet weak var rescheduleMenuImage: UIImageView!
    @IBOutlet weak var listMenuImage: UIImageView!

    @IBOutlet weak var composeModalView: UIView!
    @IBOutlet weak var composeFormView: UIView!
    @IBOutlet weak var composeFormImage: UIImageView!
    @IBOutlet weak var composeFormEmailText: UITextField!
    @IBOutlet weak var composeFormSubjectText: UITextField!

    var mailBoxViewCenter = CGPoint()
    var messageCenter = CGPoint()
    var leftIconViewOrigin = CGPoint()
    var rightIconViewOrigin = CGPoint()

    // globals
    let openMenuPosition = CGFloat(290)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.scrollView.contentSize =
            CGSize(
                width: 320,
                height:
                (self.searchBoxImage.image!.size.height +
                self.bannerImage.image!.size.height +
                self.messageImage.image!.size.height +
                self.feedImage.image!.size.height +
                self.navImage.image!.size.height
                )
        )

        // Setup mailbox view
        self.rightIconView.alpha = 0
        self.leftIconView.alpha = 0
        self.listIconImage.alpha = 0
        self.deleteIconImage.alpha = 0
        self.messageImage.frame.origin.y = 0
        self.mailBoxView.frame.origin.x = 0
        
        // hide pseudo modals
        self.modalMenuView.frame.origin.y = 0
        self.modalMenuView.alpha = 0
        self.rescheduleMenuImage.alpha = 0
        self.listMenuImage.alpha = 0
        self.composeModalView.frame.origin.y = 20
        self.composeModalView.alpha = 0

        // get origins and centers of views
        mailBoxViewCenter = self.mailBoxView.center
        messageCenter = self.messageImage.center
        leftIconViewOrigin = self.leftIconView.frame.origin
        rightIconViewOrigin = self.rightIconView.frame.origin
        
        // setup edge gesture recognizers
        // one to handle opening the hamburger menu
        var edgeGestureLeft = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePanLeft:")
        edgeGestureLeft.edges = UIRectEdge.Left
        self.mailBoxView.addGestureRecognizer(edgeGestureLeft)

        // handle closing the hamburger menu
        // via tapping
        var tapMenu = UITapGestureRecognizer(target: self, action: "tapOnMailbox:")
        self.mailBoxView.addGestureRecognizer(tapMenu)

        // via swiping from right edge
        var edgeGestureRight = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePanRight:")
        edgeGestureRight.edges = UIRectEdge.Right
        self.mailBoxView.addGestureRecognizer(edgeGestureRight)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MESSAGE PANNING
    @IBAction func onPanMessage(gestureRecognizer: UIPanGestureRecognizer) {

        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        
        let showReschedulePoint = CGFloat(-60)
        let showListPoint = CGFloat(-260)
        let archivePoint = CGFloat(60)
        let deletePoint = CGFloat(260)

        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            // do nothing
        }
        else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            // handle color and icon changes as you drag
            messageImage.center.x = translation.x + messageCenter.x

            if (translation.x > 0) {
                self.rightIconView.alpha = 0
                self.leftIconView.alpha = 1
            } else {
                self.rightIconView.alpha = 1
                self.leftIconView.alpha = 0
            }
            
            // swiping left
            if (translation.x > showReschedulePoint && translation.x < 0) {
                // swipe left to 60
                // do nothing
            }
            else if (translation.x <= showReschedulePoint && translation.x > showListPoint) {
                // swipe left between 60 and 260
                //move reschedule icon and make sure it's shown
                self.rightIconView.frame.origin.x = translation.x + rightIconViewOrigin.x + abs(showReschedulePoint)
                self.laterIconImage.alpha = 1
                self.listIconImage.alpha = 0
                
                // animate yellow color
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: { () -> Void in
                    self.actionsView.backgroundColor = UIColor(red: 249/255, green: 204/255, blue: 40/255, alpha: 1.0)
                    }, completion: nil)
            }
            else if (translation.x <= showListPoint) {
                // swipe left past 260
                // move icon and swap to list icon
                self.rightIconView.frame.origin.x = translation.x + rightIconViewOrigin.x + abs(showReschedulePoint)
                self.laterIconImage.alpha = 0
                self.listIconImage.alpha = 1

                // animate to brown color
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: { () -> Void in
                    self.actionsView.backgroundColor = UIColor(red: 206/255, green: 150/255, blue: 98/255, alpha: 1.0)
                    }, completion: nil)
            }
            
            // swiping right
            if (translation.x >= archivePoint && translation.x <= deletePoint) {
                // swipe past 60
                // show check icon and move
                self.leftIconView.frame.origin.x = translation.x + leftIconViewOrigin.x - abs(archivePoint)
                self.archiveIconImage.alpha = 1
                self.deleteIconImage.alpha = 0
                
                // change color to green
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: { () -> Void in
                    self.actionsView.backgroundColor = UIColor(red: 98/255, green: 213/255, blue: 80/255, alpha: 1.0)
                    }, completion: nil)
            }
            else if (translation.x >= deletePoint) {
                // swipe past 260
                // show delete icon
                self.leftIconView.frame.origin.x = translation.x + leftIconViewOrigin.x - abs(archivePoint)
                self.archiveIconImage.alpha = 0
                self.deleteIconImage.alpha = 1

                // change color to red
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: { () -> Void in
                    self.actionsView.backgroundColor = UIColor(red: 228/255, green: 61/255, blue: 39/255, alpha: 1.0)
                    }, completion: nil)
            }
        }
        else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            // handle closing of panel when finger is lifted
            // swiping left
            if (translation.x > showReschedulePoint && translation.x < 0) {
                // reset the color
                self.actionsView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 223/255, alpha: 1.0)
                // close the panel
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: { () -> Void in
                    self.messageImage.frame.origin.x = 0
                }, completion: nil)
            }
            else if (translation.x <= showReschedulePoint && translation.x > showListPoint) {
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: { () -> Void in
                    // expand the panel fully
                    self.messageImage.frame.origin.x = -self.messageImage.image!.size.width

                    // move reschedule icon and adjust transparency
                    self.rightIconView.frame.origin.x = abs(showReschedulePoint)
                    self.laterIconImage.alpha = 0
                    
                    // show overlay
                    self.modalMenuView.alpha = 1
                    self.rescheduleMenuImage.alpha = 1
                },  completion: nil)
            }
            else if (translation.x <= showListPoint) {
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: { () -> Void in
                    // expand the panel fully
                    self.messageImage.frame.origin.x = -self.messageImage.image!.size.width
                    
                    // move icons and adjust transparency
                    self.rightIconView.frame.origin.x = abs(showReschedulePoint)
                    self.listIconImage.alpha = 0
                    
                    // show overlay
                    self.modalMenuView.alpha = 1
                    self.listMenuImage.alpha = 1
                    },  completion: nil)
            }
            // handle right swipes
            // swiping right
            if (translation.x < archivePoint && translation.x > 0) {
                // reset the color
                self.actionsView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 223/255, alpha: 1.0)
                // close the panel
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: { () -> Void in
                    self.messageImage.frame.origin.x = 0
                    }, completion: nil)
            }
            else if (translation.x >= archivePoint && translation.x <= deletePoint) {
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: { () -> Void in
                    // expand the panel fully
                    self.messageImage.frame.origin.x = self.messageImage.image!.size.width * 2
                    
                    // move reschedule icon and adjust transparency
                    self.leftIconView.frame.origin.x = self.messageImage.image!.size.width - abs(archivePoint)
                    self.archiveIconImage.alpha = 0
                    }) { (finished: Bool) -> Void in
                        self.resetMailBox()
                }
            }
            else if (translation.x >= deletePoint) {
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: { () -> Void in
                    // expand the panel fully
                    self.messageImage.frame.origin.x = self.messageImage.image!.size.width * 2
                    
                    // move reschedule icon and adjust transparency
                    self.leftIconView.frame.origin.x = self.messageImage.image!.size.width - abs(archivePoint)
                    self.deleteIconImage.alpha = 0
                    }) { (finished: Bool) -> Void in
                        self.resetMailBox()
                }
            }
        }
        
    }

// SEGMENTED CONTROL
    @IBAction func segmentedControlChange(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
            {
        case 0:
            // change color
            self.segmentedControl.tintColor = UIColor(red: 249/255, green: 204/255, blue: 40/255, alpha: 1.0)
            // animate panel change
        case 1:
            // change color
            self.segmentedControl.tintColor = UIColor(red: 112/255, green: 197/255, blue: 224/255, alpha: 1.0)
            // animate panel change
        case 2:
            // change color
            self.segmentedControl.tintColor = UIColor(red: 98/255, green: 213/255, blue: 80/255, alpha: 1.0)
            // animate panel change
        default:
            break; 
        }
    }
    
    
// HAMBURGER MENU FUNCTIONS
    @IBAction func hamburgerIconTap(sender: AnyObject) {
        if (self.mailBoxView.frame.origin.x == self.openMenuPosition) {
            self.closeHamburger()
        } else {
            self.openHamburger()
        }
    }
    
    // swipe left - opening the hamburger menu
    func onEdgePanLeft(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)

        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            // do nothing
        }
        else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            self.mailBoxView.center.x = translation.x + mailBoxViewCenter.x
        }
        else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            if (velocity.x >= 0) {
                openHamburger()
            }
            else {
                closeHamburger()
            }
        }
    }
    // swipe right - close the menu
    func onEdgePanRight(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        closeHamburger()
    }
    // tap on mailbox - close the menu if open
    func tapOnMailbox(gestureRecognizer: UITapGestureRecognizer) {
        if (self.mailBoxView.frame.origin.x == self.openMenuPosition) {
            closeHamburger()
        }
    }
    
    // open the menu
    func openHamburger() {
        self.scrollView.scrollEnabled = false
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.mailBoxView.frame.origin.x = self.openMenuPosition
            }, completion: nil)
    }
    // close the menu
    func closeHamburger() {
        self.scrollView.scrollEnabled = true
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.mailBoxView.frame.origin.x = 0
            }, completion: nil)
    }
    
// MAILBOX
    // reset the mailbox to it's original state
    func resetMailBox() {
        // reset the icons
        self.listMenuImage.alpha = 0
        self.rescheduleMenuImage.alpha = 0
        
        // hide the menu
        self.modalMenuView.alpha = 0
        
        // collapse the message view
        UIView.animateWithDuration(0.2, delay: 0.1, options: nil, animations:{ () -> Void in
            self.feedImage.frame.origin.y -= self.messageImage.image!.size.height
            }) { (finished: Bool) -> Void in
                
                // reset the message view instantly
                self.messageImage.frame.origin.x = 0
                self.rightIconView.frame.origin.x = self.rightIconViewOrigin.x
                self.feedImage.frame.origin.y += self.messageImage.image!.size.height
                self.laterIconImage.alpha = 0
                self.archiveIconImage.alpha = 0
                self.actionsView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 223/255, alpha: 1.0)
        }
    }
    
// MODALS
    // respond to tap on modal menu
    @IBAction func modalMenuButtonTap(sender: AnyObject) {
        resetMailBox()
    }
    
    // show compose pseduo modal
    @IBAction func composeButtonTap(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.composeModalView.alpha = 1
            self.composeFormView.frame.origin.y = 60
            }) { (finished: Bool) -> Void in
        }
        self.composeFormEmailText.becomeFirstResponder()
    }

    @IBAction func composeCancelButtonTap(sender: AnyObject) {
        view.endEditing(true)
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.composeModalView.alpha = 0
            self.composeFormView.frame.origin.y = 337
            }, completion: nil)
    }
    
    @IBAction func textEmailEditingBegin(sender: UITextField) {
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
