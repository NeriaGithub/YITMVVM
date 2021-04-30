//
//  ViewController.swift
//  YIT
//
//  Created by Neria Jerafi on 26/04/2021.
//

import UIKit
import AVKit
import AVFoundation


class ViewController: UIViewController {
    @IBOutlet weak var hitTable: UITableView!{
        didSet{
            hitTable.dataSource = self
            hitTable.delegate = self
            hitTable.register(HitCell.nib(), forCellReuseIdentifier: HitCell.identifier)
            hitTable.rowHeight = UITableView.automaticDimension
            hitTable.estimatedRowHeight = 80
        }
    }
    var hitListVM:HitListViewModel?
    var videoLastDuration:Float64 = 0.0
    var avPlayerItem:AVPlayerItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hitListVM = HitListViewModel()
        hitListVM?.fetchData { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.hitTable.reloadData()
        }
    }
    
    func getCurrentItem(cell:HitCell)->AVPlayerItem?{
        guard let currentItem = cell.videoView.player?.currentItem else { return nil}
        return currentItem
    }
    
    func playVideo(cell:HitCell, currentItem:AVPlayerItem) {
        if videoLastDuration == cell.videoView.getFullDuration() {
            videoLastDuration = 0.0
        }
        let targetTime:CMTime = CMTime(seconds: videoLastDuration , preferredTimescale: 1)
        currentItem.seek(to: targetTime) { (_) in
            cell.videoView.player?.play()
        }
    }
    
    
}
extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   hitListVM?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HitCell.identifier, for: indexPath) as!  HitCell
        cell.setCell(hitVM: hitListVM!.getHitVieModelAt(index: indexPath.row), index: indexPath.row)
        return cell
    }
    
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let hitCell = cell as? HitCell else { return }
        guard let  currentItem = getCurrentItem(cell: hitCell)   else { return }
        if indexPath.row == 12 || indexPath.row == 40 {
            print("last:\(videoLastDuration)")
            avPlayerItem = currentItem
            playVideo(cell: hitCell, currentItem: currentItem)
        }else{
            hitCell.videoView.player?.pause()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 12 || indexPath.row == 40 {
            guard let hitCell = cell as? HitCell else { return }
            guard let  currentItem = getCurrentItem(cell: hitCell)   else { return }
            avPlayerItem = currentItem
            hitCell.videoView.player?.pause()
            videoLastDuration = CMTimeGetSeconds(currentItem.currentTime())
        }
    }
}

