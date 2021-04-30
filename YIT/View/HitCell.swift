//
//  HitCell.swift
//  YIT
//
//  Created by Neria Jerafi on 26/04/2021.
//

import UIKit
import AVKit
import AVFoundation

class HitCell: UITableViewCell {
    
    // MARK:- Properites
    @IBOutlet weak var hitImageView: UIImageView!
    @IBOutlet weak var videoView: PlayerView!
    var imageIsHidden:Bool = false{
        didSet{
            if imageIsHidden {
                hitImageView.isHidden = true
                videoView.isHidden = false
            }else{
                hitImageView.isHidden = false
                videoView.isHidden = true
            }
            
        }
    }
    
    // MARK: - Hit Cell Methods
    func setCell(hitVM:HitViewModel, index:Int)  {
        if index == 12 || index == 40 {
            imageIsHidden = true
            setVideoPlayer()
        }else{
            imageIsHidden = false
            hitImageView.load(stringUrl: hitVM.imageStringURl)
        }
    }
    
    func setVideoPlayer() {
        guard let url = videoView.getVideoURL() else { return}
        let avPlayer = AVPlayer(url:url)
        videoView.playerLayer.player = avPlayer
    }
    
    // MARK:- Property and methods Hit Cell class 
    static let identifier = "HitCell"
    static func nib()->UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hitImageView.image = nil
        videoView.player?.pause()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
