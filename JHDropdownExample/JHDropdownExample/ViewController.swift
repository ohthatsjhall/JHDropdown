//
//  ViewController.swift
//  JHDropdownExample
//
//  Created by Justin Hall on 4/30/16.
//  Copyright © 2016 Justin Hall. All rights reserved.
//

import UIKit
import JHDropdown

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }

  // MARK: - Button Actions
  
  @IBAction func showSuccessMessage(sender: AnyObject) {
    Dropdown.show("Success!", state: .Success, duration: 2.2) {
      // TODO: write code to run after the message is done showing
      print("Message done animating!")
    }
  }
  
  @IBAction func showErrorMessage(sender: AnyObject) {
    Dropdown.show("Oops! something went wrong, time to show an Error!", state: .Error, duration: 1.5, action: nil)
  }
  
  @IBAction func showWarningMessage(sender: AnyObject) {
    Dropdown.show("Warn users with the warning dropdown message", state: .Warning, duration: 2.5) {
      print("you've been warned!")
    }
  }
  
  @IBAction func showCustomMessage(sender: AnyObject) {
    
    let image = UIImage(named: "smile")
    let color = UIColor(red: 85.0 / 255.0, green: 136.0 / 255.0, blue: 224.0 / 255.0, alpha: 0.75)
    
    Dropdown.show(
    "Create your own custom messages by selecting the image and background color for the dropdown. It doesn't matter how long you make the message, the dropdown will adjust it's height",
    state: .Custom(color, image),
    duration: 3.0) {
      
      print("congratulations you made a custom dropdown")
      
    }
  }


}

