//
//  EpisodeDetailViewController.swift
//  Screencast
//
//  Created by Neil García on 7/14/17.
//  Copyright © 2017 SOIN. All rights reserved.
//

import UIKit
import SDWebImage

class EpisodeDetailViewController: UIViewController {
    
    @IBOutlet weak var episodeDescriptionLabel: UILabel!
    @IBOutlet weak var episodeImageView: UIImageView!
    
    lazy var episodeViewModel: EpisodeViewModel = EpisodeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initUI() {
        title = episodeViewModel.episodeTitle()
        episodeDescriptionLabel.text = episodeViewModel.episodeDescription()
        episodeImageView.sd_setImage(with: episodeViewModel.episodeImage() , placeholderImage: UIImage(named: ""))
    }

    @IBAction func gotoVideoPressed(_ sender: Any) {
       // performSegue(withIdentifier: "videoSegue", sender: nil)
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "videoSegue" {
            if let videoViewController = segue.destination as? VideoViewController {
                    videoViewController.episodeViewModel =
                        episodeViewModel
            }
        }
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }

}
