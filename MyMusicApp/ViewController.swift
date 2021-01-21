//
//  ViewController.swift
//  MyMusicApp
//
//  Created by Anamika Deb on 21/1/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var songs = [Songs]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        configureSongs()
    }
    
    func configureSongs() {
        songs.append(Songs(name: "Jony Jony Yes Papa", artistName: "Artist1", coverName: "Cover1", trackName: "Song1"))
        songs.append(Songs(name: "Baa Baa Black Sheep", artistName: "Artist2", coverName: "Cover2", trackName: "Song2"))
        songs.append(Songs(name: "Rain Rain Go Away", artistName: "Artist3", coverName: "Cover3", trackName: "Song3"))
        songs.append(Songs(name: "Twinkle Twinkle Little Star", artistName: "Artist4", coverName: "Cover4", trackName: "Song4"))
        songs.append(Songs(name: "The Wheels On The Bus", artistName: "Artist5", coverName: "Cover5", trackName: "Song5"))
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artistName
        cell.imageView?.image = UIImage(named: song.coverName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Player") as! Player
        newViewController.position = indexPath.row
        newViewController.songs = songs
        self.present(newViewController, animated: true, completion: nil)
    }
}

struct Songs {
    var name: String
    var artistName: String
    var coverName: String
    var trackName: String
}

