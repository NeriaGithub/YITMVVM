//
//  PlayerView.swift
//  YIT
//
//  Created by Neria Jerafi on 27/04/2021.
//

import UIKit
import AVKit
import AVFoundation


class PlayerView: UIView {
    
    // MARK:- Properties
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    // MARK:- Player View Methods
    func getVideoURL() -> URL? {
        guard let path = Bundle.main.path(forResource: "funny", ofType:"mp4") else {
            debugPrint("video not found")
            return nil
        }
        return URL(fileURLWithPath: path)
    }
    func getFullDuration() ->Float64 {
        if let url = getVideoURL() {
            let asset = AVAsset(url: url)
            let duration = asset.duration
            let time =  CMTimeGetSeconds(duration)
            return time
        }
        return 0.0
    }
    
}
