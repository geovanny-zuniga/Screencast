//
//  VideoViewController.swift
//  Screencast
//
//  Created by Geovanny Zuniga on 18/7/17.
//  Copyright © 2017 SOIN. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    @IBOutlet weak var videoWebView: UIWebView!
    
    lazy var episodeViewModel: EpisodeViewModel = EpisodeViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI() {

        videoWebView.loadRequest(URLRequest(url:episodeViewModel.episodeVideo()))

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/
 

}
