//
//  FlexView.swift
//  Note
//
//  Created by Muis on 20/01/20.
//

import UIKit
import ViewDSL
@_exported import FlexLayout

@objc
final class FastFlex: NSObject {
    let flex: Flex
    init(flex: Flex) {
        self.flex = flex
    }
}

@objc
protocol ViewDSLFlex: ViewDSL {
    @objc
    func flexWith(_ parent: FastFlex)
}

extension UIView: ViewDSLFlex {
    func flexWith(_ parent: FastFlex) {
        parent.flex.addItem(self)
    }
}

public class FlexView: UIView {
    @objc
    public override func put(_ view: UIView) {
        view.flexWith(FastFlex(flex: flex))
    }
    
    var isUsingSafeArea = true
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        var insets: UIEdgeInsets = .zero
        if isUsingSafeArea {
            if #available(iOS 11.0, *) {
                insets = safeAreaInsets
            }
        }
        flex.padding(insets)
        flex.layout()
    }
}
