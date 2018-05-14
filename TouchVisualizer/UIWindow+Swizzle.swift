//
//  UIWindow+Swizzle.swift
//  TouchVisualizer
//

import UIKit

fileprivate var isSwizzled = false

@available(iOS 8.0, *)
extension UIWindow {
	
	public func swizzle() {
		if (isSwizzled) {
			return
		}
		
		let sendEvent = class_getInstanceMethod(object_getClass(self), #selector(UIApplication.sendEvent(_:)))
		let swizzledSendEvent = class_getInstanceMethod(object_getClass(self), #selector(UIWindow.swizzledSendEvent(_:)))
        method_exchangeImplementations(sendEvent!, swizzledSendEvent!)
        swizzleNav()
        isSwizzled = true
    }
    
    public func swizzleNav() {
        let disappearEvent = class_getInstanceMethod(UIViewController.classForCoder(), #selector(UINavigationController.viewWillDisappear(_:)))
        let swizzledDisappearEvent = class_getInstanceMethod(UIViewController.classForCoder(), #selector(UIViewController.swizzledViewWillDisappear(_:)))
        method_exchangeImplementations(disappearEvent!, swizzledDisappearEvent!)
    }
    
    @objc public func swizzledSendEvent(_ event: UIEvent) {
        Visualizer.sharedInstance.handleEvent(event)
        swizzledSendEvent(event)
    }
    
}

extension UIViewController {
    @objc public func swizzledViewWillDisappear(_ animated: Bool) {
        Visualizer.sharedInstance.removeAllTouchViews()
        swizzledViewWillDisappear(animated)
    }
}
