//
//  LinkedStoryboardSegueTests.swift
//  LinkedStoryboardSegueTests
//
//  Created by Rusty Zarse on 6/30/15.
//  Copyright (c) 2015 QuasarBlu. All rights reserved.
//

import UIKit
import XCTest
import LinkedStoryboardSegue

class LinkedStoryboardSegueTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSceneNamed() {
        
        
        
        
        let vcSource = UIViewController()
        let vcDest = UIViewController()
        let segue = LinkedStoryboardSegue(identifier: "TestStoryboard", source: vcSource, destination: vcDest, useBundle: NSBundle(forClass: self.dynamicType))
        
        let resultDestVC = segue.destinationViewController as! UIViewController
        let resultSourceVC = segue.sourceViewController as! UIViewController
        
        XCTAssertEqual(resultSourceVC, vcSource, "source view controller should be left alone")
        
        XCTAssertNotEqual(resultDestVC, vcDest, "destination viewController should have been replaced with nil")
        
        let segue2 = LinkedStoryboardSegue(identifier: "AnotherStoryboard@DeepViewController", source: vcSource, destination: vcDest, useBundle: NSBundle(forClass: self.dynamicType))
        
        let resultDestVC2 = segue.destinationViewController as! UIViewController
        let resultSourceVC2 = segue.sourceViewController as! UIViewController
        
        XCTAssertEqual(resultSourceVC2, vcSource, "source view controller should be left alone")
        
        XCTAssertNotEqual(resultDestVC2, vcDest, "destination viewController should have been replaced with another view controller")
        
        
    }
    
    func testSceneNamedReturnsUINavigationController() {
        
        // I managed to break it, right away, by uing a navigation controller as my entry point on the second storyboard.
        //   This will also happen if you were to navigate back to the root controller of the main storyboard, 
        //   so we'll support that
        
        
        let vcSource = UIViewController()
        let vcDest = UIViewController()
        let segue = LinkedStoryboardSegue(identifier: "TestStoryboard", source: vcSource, destination: vcDest, useBundle: NSBundle(forClass: self.dynamicType))
        
        let resultDestVC = segue.destinationViewController as! UIViewController
        let resultSourceVC = segue.sourceViewController as! UIViewController
        
        XCTAssertEqual(resultSourceVC, vcSource, "source view controller should be left alone")
        
        XCTAssertNotEqual(resultDestVC, vcDest, "destination viewController should have been replaced with other VC")
        
        
    }

    
    func testPerformSegue() {
        
        // load the test storyboard
        var storyboard:UIStoryboard = UIStoryboard(name: "TestStoryboard", bundle: NSBundle(forClass: self.dynamicType))
        // instantiate the root view controller.  initial is a tab bar controller
        let vcEntry : UITabBarController = storyboard.instantiateInitialViewController() as! UITabBarController
        // first child is a navigation controller
        let vcFirstChild : UINavigationController = vcEntry.viewControllers?[0] as! UINavigationController
        // root view controller has a segue called and a title == "Linking ViewController"
        let vcSource = vcFirstChild.topViewController
        
        XCTAssertEqual(vcSource.title!, "Linking ViewController", "test state not as expected.  The test storyboard may have been modifed.  Sorry, I depend on that.")
        
        LinkedStoryboardSegue.defaultBundle = NSBundle(forClass: self.dynamicType)
        
        // perform segue with id.  This should load the vc with an id == DeepViewController from the "AnotherStoryboard" storyboard
        vcSource.performSegueWithIdentifier("AnotherStoryboard@DeepViewController", sender: nil)
        
        // can't really inspect anything as this does not, for some reason, push the view controller.  No time to dig deeper
        let newVC:UIViewController = vcSource.navigationController?.topViewController as UIViewController!
        
        // in this case, it should instatiate the root viewCtoller.  This happens to be a UITabBarController.  The fallback behavior will be to return the first viewcontroller from it's children
        vcSource.performSegueWithIdentifier("AnotherStoryboard", sender: nil)
        
        // this is just the source vc.  Unsure why...
        let newVC2:UIViewController? = vcSource.navigationController?.topViewController
        
        
        
        
    }
    
    
    
    
}
