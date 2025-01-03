//
//  SmallTextLabel.swift
//  MovieDex
//
//  Created by Luis Becerra on 23/11/24.
//

import UIKit

class MediumTextLabel: BaseLabel {
    init(text: String = "") {
        super.init(text: text, size: 16, color: .text)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
