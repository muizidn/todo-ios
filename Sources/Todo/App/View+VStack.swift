//
//  View+VStack.swift
//  Todo
//
//  Created by Muis on 25/01/20.
//

import Foundation

public class VStack: UIView {
    @objc
    override func flexWith(_ parent: FastFlex) {
        parent.flex
            .addItem(self)
        isReverse = false
    }
    
    var isReverse = false {
        didSet {
            flex.direction(isReverse ? .columnReverse : .column)
        }
    }
}
