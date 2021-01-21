//
//  Player.swift
//  MyMusicApp
//
//  Created by Anamika Deb on 21/1/21.
//

import UIKit
import AVFoundation

class Player: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var artistNameLbl: UILabel!
    
    var songs: [Songs] = []
    var position: Int = 0
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuareView()
        configuarePlayer()
    }
    
    func configuarePlayer() {
        let song = songs[position]
        //set player
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                return
            }
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            guard let player = player else {
                return
            }
            player.play()
        } catch  {
            print("Error")
        }
    }
    
    func configuareView() {
        let song = songs[position]
        //set UI Elements
        imageView.image = UIImage(named: song.coverName)
        imageView.contentMode = .scaleAspectFill
        
        nameLbl.text = song.name
        artistNameLbl.text = song.artistName
        
        playPauseBtn.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let player = player else {
            return
        }
        player.stop()
    }
    
    @IBAction func tapPlayPauseButton(sender: Any){
        if player?.isPlaying == true{
            player?.pause()
            playPauseBtn.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else
        {
            player?.play()
            playPauseBtn.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    @IBAction func tapBackButton(sender: Any){
        if position > 0{
            position = position - 1
            player?.stop()
            
            configuareView()
            configuarePlayer()
        }
    }
    
    @IBAction func tapNextButton(sender: Any){
        if position < songs.count - 1{
            position = position + 1
            player?.stop()
            
            configuareView()
            configuarePlayer()
        }
    }
    
    @IBAction func changeVolume(sender: UISlider){
        let value = sender.value
        player?.volume = value
    }
}

