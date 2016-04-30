//
//  Dropdown.swift
//  JHDropdown
//
//  Created by Justin Hall on 4/24/16.
//  Copyright © 2016 Justin Hall. All rights reserved.
//

import UIKit

public protocol DropdownStatable {
  var backgroundColor: UIColor? { get }
  var font: UIFont? { get }
  var textColor: UIColor? { get }
  var image: UIImage? { get }
}

public enum DropdownState: DropdownStatable {
  
  case Success
  case Error
  case Warning
  case Custom(UIColor, UIImage?)
  
  public var backgroundColor: UIColor? {
    switch self {
    case .Warning:
      return UIColor(white: 0.5, alpha: 0.88)
    case .Success:
      return UIColor(red: 88.0 / 255.0, green: 178.0 / 255.0, blue: 51.0 / 255.0, alpha: 0.88)
    case .Error:
      return UIColor(red: 205.0 / 255.0, green: 54.0 / 255.0, blue: 54.0 / 255.0, alpha: 0.88)
    case .Custom (let color, _):
      return color
    }
  }
  
  public var image: UIImage? {
    switch self {
    case .Success:
      return imageFromBundleNamed("success")
    case .Error:
      return imageFromBundleNamed("error")
    case .Warning:
      return imageFromBundleNamed("warning")
    case .Custom(_ ,let customImage):
      if let customImage = customImage {
        return customImage
      } else { return nil }
    }
  }
  
  public var font: UIFont? {
    return UIFont.systemFontOfSize(16.0)
  }
  
  public var textColor: UIColor? {
    return UIColor.whiteColor()
  }
  
  private func imageFromBundleNamed(named: String) -> UIImage? {
    let bundle = NSBundle(forClass: Dropdown.self)
    let image = UIImage(named: named, inBundle: bundle, compatibleWithTraitCollection: nil)
    return image
  }
  
}

public typealias DropdownAction = () -> Void

public final class Dropdown: UIView {
  
  static let presentDuration: NSTimeInterval = 4.0
  
  private var statusLabel: UILabel!
  private var imageView: UIImageView!
  private let statusTopMargin: CGFloat = 10.0
  private let statusBottomMargin: CGFloat = 10.0
  private var minimumHeight: CGFloat { return UIApplication.sharedApplication().statusBarFrame.height + 44.0 }
  private var topConstraint: NSLayoutConstraint?
  private var heightConstraint: NSLayoutConstraint?
  
  private var duration: NSTimeInterval = Dropdown.presentDuration
  
  private var startTop: CGFloat?
  
  private var action: DropdownAction?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  convenience init(duration: Double) {
    self.init(frame: CGRect.zero)
    self.duration = duration
    
    NSNotificationCenter.defaultCenter().addObserver(
      self,
      selector: #selector(Dropdown.deviceOrientationDidChange(_:)),
      name: UIDeviceOrientationDidChangeNotification,
      object: nil)
  }
  
  public func deviceOrientationDidChange(notification: NSNotification) {
    updateHeight()
  }
  
  private func updateHeight() {
    var height: CGFloat = 0.0
    height += UIApplication.sharedApplication().statusBarFrame.height
    height += statusTopMargin
    height += statusLabel.frame.size.height
    height += statusBottomMargin
    heightConstraint?.constant = height > minimumHeight ? height : minimumHeight
    self.layoutIfNeeded()
  }
  
  
}

extension Dropdown {
  
  public class func show(status: String, state: DropdownState, duration: Double, action: DropdownAction?) {
    present(status, state: state, duration: duration, action: action)
  }
  
  private class func present(status: String, state: DropdownState, duration: Double, action: DropdownAction?) {
    let drop = Dropdown(duration: duration)
    UIApplication.sharedApplication().keyWindow?.addSubview(drop)
    guard let window = drop.window else { return }
    
    let heightConstraint = NSLayoutConstraint(
      item: drop,
      attribute: .Height,
      relatedBy: .Equal,
      toItem: nil,
      attribute: .Height,
      multiplier: 1.0,
      constant: 100.0)
    
    drop.addConstraint(heightConstraint)
    drop.heightConstraint = heightConstraint
    
    let topConstraint = NSLayoutConstraint(
      item: drop,
      attribute: .Top,
      relatedBy: .Equal,
      toItem: window,
      attribute: .Top,
      multiplier: 1.0,
      constant: -heightConstraint.constant)
    
    drop.topConstraint = topConstraint
    
    window.addConstraints(
      [
        topConstraint,
        NSLayoutConstraint(
          item: drop,
          attribute: .Left,
          relatedBy: .Equal,
          toItem: window,
          attribute: .Left,
          multiplier: 1.0,
          constant: 0.0),
        NSLayoutConstraint(
          item: drop,
          attribute: .Right,
          relatedBy: .Equal,
          toItem: window,
          attribute: .Right,
          multiplier: 1.0,
          constant: 0.0)
      ]
    )
    
    drop.setup(status, state: state)
    drop.updateHeight()
    
    topConstraint.constant = 0.0
    
    UIView.animateWithDuration(
      duration,
      delay: 0.0,
      usingSpringWithDamping: 0.55,
      initialSpringVelocity: 0.0,
      options: [.Autoreverse, .CurveEaseOut],
      animations: { [weak drop] () -> Void in
        
        if let drop = drop { drop.layoutIfNeeded() }
        
    }) { (Bool) in
      
      action?()
      drop.removeFromSuperview()
      //drop.transform = CGAffineTransformIdentity
      
    }
  }
  
}

extension Dropdown {
  
  private func setup(status: String, state: DropdownStatable) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let labelParentView: UIView = self
    
    let backgroundView = UIView(frame: CGRect.zero)
    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    backgroundView.backgroundColor = state.backgroundColor
    addSubview(backgroundView)
    addConstraints(
      
      [
        NSLayoutConstraint(
          item: backgroundView,
          attribute: .Left,
          relatedBy: .Equal,
          toItem: self,
          attribute: .Left,
          multiplier: 1.0,
          constant: 0.0),
        
        NSLayoutConstraint(
          item: backgroundView,
          attribute: .Top,
          relatedBy: .Equal,
          toItem: self,
          attribute: .Top,
          multiplier: 1.0,
          constant: -UIScreen.mainScreen().bounds.height),
        
        NSLayoutConstraint(
          item: backgroundView,
          attribute: .Right,
          relatedBy: .Equal,
          toItem: self,
          attribute: .Right,
          multiplier: 1.0,
          constant: 0.0),
        
        NSLayoutConstraint(
          item: backgroundView,
          attribute: .Bottom,
          relatedBy: .Equal,
          toItem: self,
          attribute: .Bottom,
          multiplier: 1.0,
          constant: 0.0),
      ]
    )
    
    let imageView = UIImageView(frame: CGRect.zero)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .ScaleAspectFit
    imageView.image = state.image
    addSubview(imageView)
    addConstraints(
      
      [
        NSLayoutConstraint(
          item: imageView,
          attribute: .Height,
          relatedBy: .Equal,
          toItem: nil,
          attribute: .NotAnAttribute,
          multiplier: 1.0,
          constant: 25.0),
        
        NSLayoutConstraint(
          item: imageView,
          attribute: .Width,
          relatedBy: .Equal,
          toItem: nil,
          attribute: .NotAnAttribute,
          multiplier: 1.0,
          constant: 25.0),
        
        NSLayoutConstraint(
          item: imageView,
          attribute: .Leading,
          relatedBy: .Equal,
          toItem: self,
          attribute: .Leading,
          multiplier: 1.0,
          constant: 8.0),
        
        NSLayoutConstraint(item: imageView,
          attribute: .CenterY,
          relatedBy: .Equal,
          toItem: self,
          attribute: .CenterY,
          multiplier: 1.0,
          constant: 0.0)
      ]
      
    )
    
    let statusLabel = UILabel(frame: CGRect.zero)
    statusLabel.translatesAutoresizingMaskIntoConstraints = false
    statusLabel.numberOfLines = 0
    statusLabel.font = state.font ?? UIFont.systemFontOfSize(17.0)
    statusLabel.textAlignment = .Center
    statusLabel.text = status
    statusLabel.textColor = state.textColor ?? .whiteColor()
    labelParentView.addSubview(statusLabel)
    labelParentView.addConstraints(
      
      [
        NSLayoutConstraint(
          item: statusLabel,
          attribute: .Leading,
          relatedBy: .Equal,
          toItem: imageView,
          attribute: .Trailing,
          multiplier: 1.0,
          constant: 8.0),
        
        NSLayoutConstraint(
          item: statusLabel,
          attribute: .Right,
          relatedBy: .Equal,
          toItem: labelParentView,
          attribute: .RightMargin,
          multiplier: 1.0,
          constant: 0.0),
        
        NSLayoutConstraint(
          item: statusLabel,
          attribute: .Bottom,
          relatedBy: .Equal,
          toItem: labelParentView,
          attribute: .Bottom,
          multiplier: 1.0,
          constant: -statusBottomMargin)
      ]
    )
    
    self.imageView = imageView
    self.statusLabel = statusLabel
    self.layoutIfNeeded()
  }
  
  
  
  // END
}
