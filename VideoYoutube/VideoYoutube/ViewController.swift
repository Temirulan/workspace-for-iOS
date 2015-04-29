//
//  ViewController.swift
//  VideoYoutube
//
//  Created by Mussayev Temirulan Zamirbekovich on 4/20/15.
//  Copyright (c) 2015 Mussayev Temirulan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var player: YouTubePlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        player.playerVars = ["playsinline": "1"]
        player.loadVideoID("Rva9ylPHi2w")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

