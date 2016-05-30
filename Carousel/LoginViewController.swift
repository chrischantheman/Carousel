//
//  LoginViewController.swift
//  Carousel
//
//  Created by Christopher Chan on 5/27/16.
//  Copyright © 2016 Christopher Chan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIScrollViewDelegate {

    var buttonInitialY: CGFloat!
    var buttonOffset: CGFloat!

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var buttonParentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func goBack(sender: AnyObject) {
        navigationController!.popViewControllerAnimated(true)
    }

    
    @IBAction func didPressLogin(sender: AnyObject) {
        // Start animating the activity indicator
        loginIndicator.startAnimating()
        // Set the Button state to "Selected"
        loginButton.selected = true
        
        if emailField.text!.isEmpty || passwordField.text!.isEmpty {
            // Alert message for empty fields
            let alertController = UIAlertController(title: "Email/Password Required", message: "Please enter your email/password", preferredStyle: .Alert)
            // create a cancel action
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                // handle cancel response here. Doing nothing will dismiss the view.
            }
            // add the cancel action to the alertController
            alertController.addAction(cancelAction)
            
            presentViewController(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }

        }
        // If both the email and password fields match what we are looking for...
        if emailField.text == "chan" && passwordField.text == "man" {
            // Delay for 2 second.
            delay(2, closure: { () -> () in
                // Stop animating the activity indicator.
                self.loginIndicator.stopAnimating()
                // Set the button state back to default, "Not Selected".
                self.loginButton.selected = false
                // perform the Segue to the next screen.
                self.performSegueWithIdentifier("loginSuccessSegue", sender: self)
            })
            // Otherwise, email or password are incorrect so...
        } else {
            // Delay for 2 second
            delay(2, closure: { () -> () in
                // Stop animating the activity indicator.
                self.loginIndicator.stopAnimating()
                // Set the button state back to default, "Not Selected".
                self.loginButton.selected = false
                // Create and Show UIAlertController...see guide, Using UIAlertController
            })
            // Alert message for empty fields
            let alertController = UIAlertController(title: "Incorrect Email/Password combo", message: "Please re-enter your email/password", preferredStyle: .Alert)
            // create a cancel action
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                // handle cancel response here. Doing nothing will dismiss the view.
            }
            // add the cancel action to the alertController
            alertController.addAction(cancelAction)
            
            presentViewController(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }

        }
    }

   override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = scrollView.frame.size
        scrollView.contentInset.bottom = 100
        scrollView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
        
        buttonInitialY = buttonParentView.frame.origin.y
        buttonOffset = -120
        
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // This method is called as the user scrolls
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // This method is called when the scrollview finally stops scrolling.
    }

    func keyboardWillShow(notification: NSNotification!) {
        // Move the button up above keyboard
        buttonParentView.frame.origin.y = buttonInitialY + buttonOffset
        // Scroll the scrollview up
        scrollView.contentOffset.y = scrollView.contentInset.bottom
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        buttonParentView.frame.origin.y = buttonInitialY

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
