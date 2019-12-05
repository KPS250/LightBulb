import Foundation
import UIKit

@objc(Bulb)

class Bulb: NSObject {
  @objc
  static var isOn = false
 
  @objc
  func turnOn() {
    Bulb.isOn = true
    print("Bulb is now ON")
  }
  
  @objc
  func turnOff() {
    Bulb.isOn = false
    print("Bulb is now OFF")
  }

  @objc
  func toast() {
    //UIApplication.topViewController()!.makeToast("Acount created Successfully", duration: 0.5, position: "bottom")
    self.showToast(controller: UIApplication.topViewController()! , message: "String", seconds: 2)
  }
  
  @objc
  func getStatus(_ callback: RCTResponseSenderBlock) {
    callback([NSNull(), Bulb.isOn])
  }
  
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  func showToast (controller : UIViewController, message : String, seconds: Double){
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    controller.present(alert, animated: true)
    alert.view.tintColor = .white
    alert.view.backgroundColor = .black
    alert.view.alpha = 0.5
    alert.view.isOpaque = false
    alert.view.layer.cornerRadius = 15
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
      alert.dismiss(animated: true)
    }
    
    print("Toast is coming!!!")
  }
  
  
}

public extension UIApplication {
  
  class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let nav = base as? UINavigationController {
      return topViewController(base: nav.visibleViewController)
    }
    if let tab = base as? UITabBarController {
      let moreNavigationController = tab.moreNavigationController
      
      if let top = moreNavigationController.topViewController, top.view.window != nil {
        return topViewController(base: top)
      } else if let selected = tab.selectedViewController {
        return topViewController(base: selected)
      }
    }
    if let presented = base?.presentedViewController {
      return topViewController(base: presented)
    }
    return base
  }
}
