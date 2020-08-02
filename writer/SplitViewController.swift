//
//  SplitViewController.swift
//  writer
//
//  Created by Jake Bloom on 31/7/20.
//  Copyright © 2020 Jake Bloom. All rights reserved.
//

import Foundation
import Cocoa
import Down
import WebKit

class SplitViewController: NSViewController, NSTextViewDelegate {
    @IBOutlet weak var input: NSTextView?
    @IBOutlet weak var rightView: NSView?

    var output: DownView?
    
    override func viewDidLoad() {
        input!.delegate = self
        input!.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)

        do {
            output = try DownView(frame: rightView!.bounds, markdownString: "")
            rightView!.addSubview(output!)
            let constraints = [
                buildConstraint(attribute: .top),
                buildConstraint(attribute: .bottom),
                buildConstraint(attribute: .left),
                buildConstraint(attribute: .right),
            ]
            rightView!.addConstraints(constraints)

        } catch {
            NSLog("Init error: ", error.localizedDescription)
        }
    }
    
    func textDidChange(_ notification: Notification) {
        do {
            try output!.update(markdownString: input!.string)
        } catch {
            NSLog(error.localizedDescription)
        }
    }
    
    func buildConstraint(attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint {
        let c = NSLayoutConstraint(item: rightView, attribute: attribute, relatedBy: .equal, toItem: output, attribute: attribute, multiplier: 1, constant: 0)
        c.isActive = true
        return c
    }
}
