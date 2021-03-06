//
//  ScreencastEpisodeListTableViewController.swift
//  Screencast
//
//  Created by Neil García on 7/14/17.
//  Copyright © 2017 SOIN. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class ScreencastEpisodeListTableViewController: UITableViewController {

    var disposeBag = DisposeBag()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    lazy var episodeListViewModel = EpisodeListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignals()
        initUI()
        episodeListViewModel.getEpisode()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupSignals() {
        episodeListViewModel.updatedContentSignal.observeOn(MainScheduler.instance).subscribe( onNext: { [weak self] _ in
            if let strongSelf = self {
                strongSelf.tableView.reloadData()
            }
            
        }).addDisposableTo(disposeBag)
    
        episodeListViewModel.beginLoadingSignal.observeOn(MainScheduler.instance).subscribe(onNext: { _ in
                SVProgressHUD.show(withStatus: "Cargando")
            
        }).addDisposableTo(disposeBag)
        
        episodeListViewModel.endLoadingSignal.observeOn(MainScheduler.instance).subscribe(onNext: { _ in
                SVProgressHUD.dismiss()
            
        }).addDisposableTo(disposeBag)
        
    }

    func initUI() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    // MARK: - UI Actions
    
    
    @IBAction func reloadButtonPressed(_ sender: Any) {
        episodeListViewModel.getEpisode()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return episodeListViewModel.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeListViewModel.numberOfRowsInSection(section)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EpisodeTableViewCell
        cell.setupCell(title: episodeListViewModel.title(atIndex: indexPath), subTitle: episodeListViewModel.subTitle(atIndex: indexPath), imageURL: episodeListViewModel.imageURL(atIndex: indexPath))
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetailSegue", sender: episodeListViewModel.object(atIndex: indexPath))
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
//        filteredCandies = candies.filter { candy in
//            return candy.name.lowercaseString.containsString(searchText.lowercaseString)
//        }
//        
//        tableView.reloadData()
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            if let episodeDetailViewController = segue.destination as? EpisodeDetailViewController {
                episodeDetailViewController.episodeViewModel = EpisodeViewModel(episode: sender as! MEpisode)
            }
        }
        
    }
}

extension ScreencastEpisodeListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let textToSearch = searchController.searchBar.text, !textToSearch.isEmpty {
            episodeListViewModel.isFiltered = true
            episodeListViewModel.filter(byText: textToSearch)
            tableView.reloadData()
        } else {
            episodeListViewModel.isFiltered = false
            tableView.reloadData()
        }
    }
}
extension ScreencastEpisodeListTableViewController: UISearchBarDelegate {
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        episodeListViewModel.isFiltered = false
        tableView.reloadData()
    }
}

