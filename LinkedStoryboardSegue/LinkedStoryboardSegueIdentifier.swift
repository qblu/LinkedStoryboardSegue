//
//  LinkedSegueIdentifier.swift
//  LinkedStoryboardSegue
//
//  Created by Rusty Zarse on 6/30/15.
//  Copyright (c) 2015 QuasarBlu. All rights reserved.
//

import Foundation

public class LinkedStoryboardSegueIdentifier{
    public var storyboardName: String
    public var sceneName: String?
    static let expectedIdentifierExample = "MyAwesomeStoryboard@HotPantsViewController"
    
    public init!(identifier:NSString){
        let badIdentifierMessage = "LinkedStoryboardSegue: failed to load a storyboard using the identifier:[\(identifier)].\n  This is where you specify the storyboard name and, optionally, the scene to present, separated by \"@\".\n  example: " + LinkedStoryboardSegueIdentifier.expectedIdentifierExample
        
        
        // split the identifier on @.  Yep, that's a hack ;]
        let info = identifier.componentsSeparatedByString("@")
        // look for the storyboard name before the @
        let stringComponent = info[0] as! String
        storyboardName = stringComponent
        
        if(storyboardName.isEmpty) {
            println(badIdentifierMessage + "\n  Empty identifier was configured for the segue")
        }
        
        // look for ViewController name after the @
        if (info.count > 1) {
            if let let stringComponent = info[1] as? String {
                sceneName = stringComponent
            }
        }
    }
}
