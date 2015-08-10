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
            println("LinkedStoryboardSegue: failed! nil identifier.\n  expected format: " + LinkedStoryboardSegueIdentifier.expectedIdentifierExample)
            return nil
        }
        
        let segueIndentifier = LinkedStoryboardSegueIdentifier(identifier:identifier!)
        
        // load the storyboard
        storyboard = UIStoryboard(name: segueIndentifier.storyboardName, bundle: storyboardBundle)
        
        // if provided a scene name, use it.  Otherwise, use initial from storyboard
        if (segueIndentifier.sceneName == nil) {
            scene = storyboard.instantiateInitialViewController() as? UIViewController
        } else {
            scene = storyboard.instantiateViewControllerWithIdentifier(segueIndentifier.sceneName!) as? UIViewController
        }
        
        if(scene == nil){
            println("LinkedStoryboardSegue: unable to load scene using the provided identifier:[\(identifier)].\n  expected format: " + LinkedStoryboardSegueIdentifier.expectedIdentifierExample)
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
        if let invalidNavControllerToPush = fixedDestination as? UINavigationController {
            // ah, snap!  Let's message the dev'r
            println("Invalid request to push a UINavigationController on a UINavigationController. Pushing the destination rootViewController instead")
            // and replace the ref with the topViewController
            // yes, this is fragile, but it's already improper so...
            fixedDestination = (fixedDestination as! UINavigationController).viewControllers[0] as! UIViewController
        }
        return fixedDestination
    }
    
    public override func perform() {
        // gather our view controllers
        let source = self.sourceViewController as! UIViewController
        var destination = self.destinationViewController as! UIViewController
        // fix the destination should it be a UINavigationController (that's no good in a push)
        destination = fixDestinationViewControllerForNavigationRootControllers(destination)
        // push it real good...
        source.navigationController?.pushViewController(destination, animated:true)
    }

    
   
}


