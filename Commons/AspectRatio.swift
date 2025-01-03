//
//  AspectRatio.swift
//  MovieDex
//
//  Created by Luis Becerra on 11/12/24.
//

import UIKit

extension UIImage {
    var aspectRatio: CGFloat {
        return self.size.width / self.size.height
    }
}

