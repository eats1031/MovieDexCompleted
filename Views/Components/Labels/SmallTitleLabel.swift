//
//  TitleLabel.swift
//  MovieDex
//
//  Created by Luis Becerra on 20/11/24.
//

import UIKit

class SmallTitleLabel: BaseLabel {
    init(text: String = "") {
        super.init(text: text, size: 14, color: .title, isBold: true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
