//
//  RemoteImage.swift
//  MovieDex
//
//  Created by Luis Becerra on 19/11/24.
//

import SwiftUI
import UIKit

class RemoteImageView: UIImageView {
    private var path: String
    private var fillMode: UIView.ContentMode
    private var hideIfUrlIsEmpty: Bool = false
    private let service: ImageService
    var didSetupImage: ((UIImage?) -> Void)? = nil

    init(
        path: String, fillMode: UIView.ContentMode = .scaleAspectFill,
        hideIfUrlIsEmpty: Bool = false
    ) {
        self.path = path
        self.fillMode = fillMode
        self.hideIfUrlIsEmpty = hideIfUrlIsEmpty
        self.service = ImageService()
        super.init(frame: .zero)
        self.clipsToBounds = true
        addElements()
        loadImage()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addElements() {
        self.backgroundColor = .clear
    }

    private func setupImage(image: UIImage? = nil) {
        if let image {
            self.image = image
        } else {
            if !hideIfUrlIsEmpty {
                self.contentMode = .scaleAspectFit
                self.image = UIImage(named: "defaultImage")
            } else {
                isHidden = true
            }
        }
        self.contentMode = fillMode
        self.didSetupImage?(image)
    }

    private func loadImage() {
        if path == "" {
            self.setupImage()
            return
        }

        Task {
            do {
                let fetchedData = try await service.fetchImage(path: path)
                if let fetchedImage = UIImage(data: fetchedData) {
                    DispatchQueue.main.async {
                        self.setupImage(image: fetchedImage)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.setupImage()
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.setupImage()
                }
            }
        }
    }

    func updatePath(path: String) {
        self.path = path
        loadImage()
    }

    func updatePath(path: String, fillMode: UIView.ContentMode) {
        self.path = path
        self.fillMode = fillMode
        loadImage()
    }
}

// MARK: - Preview SwiftUI
struct RemoteImageViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> RemoteImageView {
        let view = RemoteImageView(path: "/lzQgrRH0xkhlY0eTg8kFXlKd7KT.jpg")
        return view
    }

    func updateUIView(_ uiView: RemoteImageView, context: Context) {

    }
}

#Preview {
    RemoteImageViewRepresentable()
}
