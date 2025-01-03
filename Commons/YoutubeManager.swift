//
//  YoutubeManager.swift
//  MovieDex
//
//  Created by Luis Becerra on 26/11/24.
//
import Foundation
import UIKit

private func openYouTubeLinkFromWeb(videoId: String) {
    if let url = URL(string: "https://www.youtube.com/watch?v=\(videoId)") {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("No se puede abrir la URL")
        }
    }
}

func openYouTubeLink(videoId: String) {
    let youtubeAppURL = URL(string: "youtube://\(videoId)")!

    if UIApplication.shared.canOpenURL(youtubeAppURL) {
        UIApplication.shared.open(youtubeAppURL, options: [:], completionHandler: nil)
    } else {
        openYouTubeLinkFromWeb(videoId: videoId)
    }
}
