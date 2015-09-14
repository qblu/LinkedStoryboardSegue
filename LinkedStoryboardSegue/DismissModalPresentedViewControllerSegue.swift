//
//  DismissModalPresentedViewControllerSegue.swift
//  LinkedStoryboardSegue
//
//  Created by Rusty Zarse on 6/30/15.
//  Copyright (c) 2015 QuasarBlu. All rights reserved.
//

import Foundation
public class DismissModalPresentedViewControllerSegue:UIStoryboardSegue{
    public override func perform() {
        self.sourceViewController.presentingViewController?.dismissViewControllerAnimated(true, completion:nil)
    }
}