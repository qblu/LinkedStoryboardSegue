//
//  LinkedStoryboardModalSegue.swift
//  LinkedStoryboardSegue
//
//  Created by Rusty Zarse on 6/30/15.
//  Copyright (c) 2015 QuasarBlu. All rights reserved.
//

import Foundation
public class LinkedStoryboardModalSegue : LinkedStoryboardSegue {
    public override func perform() {
        // gather our view controllers
        let source = self.sourceViewController 
        let destination = self.destinationViewController 
        // Since this is a modal, a UINavigationController should be ok, not fiing like in the baseClass
        source.presentViewController(destination, animated: true, completion: nil)
    }
}
