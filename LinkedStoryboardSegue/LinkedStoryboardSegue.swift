//
//  LinkedStoryboardSegue.swift
//  LinkedStoryboardSegue
//
//  Created by Rusty Zarse on 6/30/15.
//  Copyright (c) 2015 QuasarBlu. All rights reserved.
//

import Foundation
import UIKit

public class LinkedStoryboardSegue : UIStoryboardSegue{
  
    public static var defaultBundle: NSBundle? = nil
    
    class func sceneNamed(identifier: NSString?, useBundle: NSBundle?) -> UIViewController? {
        
        let storyboard: UIStoryboard
        let scene: UIViewController?
        let storyboardBundle = useBundle
        
        if(identifier == nil) {
            print("LinkedStoryboardSegue: failed! nil identifier.\n  expected format: " + LinkedStoryboardSegueIdentifier.expectedIdentifierExample)
            return nil
        }
        
        let segueIndentifier = LinkedStoryboardSegueIdentifier(identifier:identifier!)
        
        // load the storyboard
        storyboard = UIStoryboard(name: segueIndentifier.storyboardName, bundle: storyboardBundle)
        
        // if provided a scene name, use it.  Otherwise, use initial from storyboard
        if let sceneName = segueIndentifier.sceneName {
            scene = storyboard.instantiateViewControllerWithIdentifier(sceneName)
        } else {
            scene = storyboard.instantiateInitialViewController()
        }
        
        if(scene == nil){
            print("LinkedStoryboardSegue: unable to load scene using the provided identifier:[\(identifier)].\n  expected format: " + LinkedStoryboardSegueIdentifier.expectedIdentifierExample)
        }
        
        return scene;
    }


    public init!(identifier: String?, source: UIViewController, destination: UIViewController, useBundle: NSBundle?) {
        if let linkedViewController = LinkedStoryboardSegue.sceneNamed(identifier, useBundle:useBundle) {
            super.init(identifier: identifier, source: source, destination: linkedViewController)
        } else {
            super.init(identifier: identifier, source: source, destination: destination)
        }
    }
    
    public override convenience init(identifier: String?, source: UIViewController, destination: UIViewController) {
        self.init(identifier:identifier, source:source, destination:destination, useBundle:LinkedStoryboardSegue.defaultBundle)
    }
    
    func fixDestinationViewControllerForNavigationRootControllers(destination:UIViewController) -> UIViewController {
        var fixedDestination = destination
        // check to see if this is a UINavigationController
        if fixedDestination is UINavigationController {
            // ah, snap!  Let's message the dev'r
            print("Invalid request to push a UINavigationController on a UINavigationController. Pushing the destination rootViewController instead")
            // and replace the ref with the topViewController
            // yes, this is fragile, but it's already improper so...
            fixedDestination = (fixedDestination as! UINavigationController).viewControllers[0] 
        }
        return fixedDestination
    }
    
    public override func perform() {
        // gather our view controllers
        let source = self.sourceViewController 
        var destination = self.destinationViewController 
        // fix the destination should it be a UINavigationController (that's no good in a push)
        destination = fixDestinationViewControllerForNavigationRootControllers(destination)
        // push it real good...
        guard let navigationController = source.navigationController else {
            print("LinkedStoryboardSegue.perform(): Source \(source) has no navigationController")
            return
        }
        navigationController.pushViewController(destination, animated:true)
    }

    
   
}


