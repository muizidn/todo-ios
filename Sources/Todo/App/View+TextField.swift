//
//  View+TextField.swift
//  TodoApp
//
//  Created by Muis on 03/02/20.
//

import Material

class TextField: Material.TextField {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = nil
    }
}
