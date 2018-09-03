//
//  InjectingSegue.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 22-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import UIKit

class InjectingSegue: UIStoryboardSegue {
    override func perform() {
        destination.storyboard?.configure(viewController: destination)
        super.perform()
    }
}
