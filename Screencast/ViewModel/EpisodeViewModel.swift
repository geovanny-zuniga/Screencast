//
//  EpisodeViewModel.swift
//  Screencast
//
//  Created by Neil García on 7/14/17.
//  Copyright © 2017 SOIN. All rights reserved.
//

import UIKit

class EpisodeViewModel: NSObject {
    
    private var episode: MEpisode?
    
    override init() {
        
    }
    
    init(episode: MEpisode) {
        self.episode = episode
    }
    
    func episodeTitle() -> String {
        return episode!.title
    }
    
    func episodeDescription() -> String {
        return "Description : \(episode!.description)"
    }
    
    func episodeImage() -> URL {
        return episode!.largeArtwork!
    }
    
    func episodeVideo() -> URL {
        return episode!.videoURL!
    }
    
}
