//
//  TitleLabel.swift
//  MovieDex
//
//  Created by Luis Becerra on 20/11/24.
//

import UIKit

class SubTitleLabel: BaseLabel {
    init(text: String = "") {
        super.init(text: text, size: 18, color: .title2, isBold: true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
