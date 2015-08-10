//
//  LinkedSegueIdentifierTests.swift
//  LinkedStoryboardSegue
//
//  Created by Rusty Zarse on 6/30/15.
//  Copyright (c) 2015 QuasarBlu. All rights reserved.
//

import Foundation
import UIKit
import XCTest
import LinkedStoryboardSegue

class LinkedStoryboardSegueIdentifierTests: XCTestCase {
    func testSceneNamed() {
        
        // test a storyboard name
        let sbName = "MyStoryboardName"
        let vcName = "MyStoryboardName"
        
        var id = LinkedStoryboardSegueIdentifier(identifier:sbName)
        XCTAssertEqual(id.storyboardName, sbName)
        XCTAssertNil(id.sceneName)
        
        // test a valid storyboard name with a viewcontroller name
        let sbAndVcNameIdentifier = sbName + "@" + vcName
        id = LinkedStoryboardSegueIdentifier(identifier:sbAndVcNameIdentifier)
        XCTAssertEqual(id.storyboardName, sbName)
        XCTAssertEqual(id.sceneName!, vcName)
        
   
        
        // test an empty string
        id = LinkedStoryboardSegueIdentifier(identifier:"")
        XCTAssertEqual(id.storyboardName,"")
        XCTAssertNil(id.sceneName)
        
    }
}