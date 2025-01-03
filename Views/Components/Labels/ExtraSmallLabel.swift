//
//  SmallTextLabel.swift
//  MovieDex
//
//  Created by Luis Becerra on 23/11/24.
//

import UIKit

class ExtraSmallLabel: BaseLabel {
    init(text: String = "") {
        super.init(text: text, size: 12, color: .text)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
