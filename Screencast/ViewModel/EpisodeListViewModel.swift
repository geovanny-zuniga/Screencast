//
//  EpisodeListViewModel.swift
//  Screencast
//
//  Created by Neil García on 7/14/17.
//  Copyright © 2017 SOIN. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import Moya_ObjectMapper


/// Episode list view model to present episode list.
class EpisodeListViewModel: DataSource {

    var disposeBag = DisposeBag()
    
    var updatedContentSignal = PublishSubject<[MEpisode]?>()
    
    var beginLoadingSignal = PublishSubject<Any?>()
    
    var endLoadingSignal = PublishSubject<Any?>()
    
    var isFiltered: Bool = false
    
    /// Text to filter
    private var filterText = ""
    
    var episodes: [MEpisode] = [MEpisode]()
    
    // Filtered episodes.
    var filteredEpisodes: [MEpisode] = [MEpisode]()
    
    func getEpisode()  {
        beginLoadingSignal.onNext(nil)
        let provider = RxMoyaProvider<ScreencastApi>()
        let getEpisodeListEnum = ScreencastApi.episodeList()
        provider.request(getEpisodeListEnum)
            .mapObject(MEpisodeResponse.self)
            .subscribe { [weak self] event -> Void  in
                if let strongSelf = self {
                    switch event {
                    case .next(let episodesObject):
                        strongSelf.episodes = episodesObject.episodes
                        strongSelf.filteredEpisodes = strongSelf.episodes
                        strongSelf.updatedContentSignal.onNext(nil)
                        strongSelf.endLoadingSignal.onNext(nil)
                    case .error(let error):
                        print(error)
                        strongSelf.endLoadingSignal.onNext(nil)
                    default:
                        break
                    }
 
                }
            }.addDisposableTo(disposeBag)
        
    }
    
    /// Filter the episodes array and create a filtered array.
    ///
    /// - Parameter byText: text for the filter.
    func filter(byText: String) {
        filteredEpisodes.removeAll()
        for episodes in self.episodes {
            if episodes.title.uppercased().contains(byText.uppercased()) {
                filteredEpisodes.append(episodes)
            }
        }
    }
    func hasData() -> Bool {
        return (episodes.count != 0)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        var returnValue = episodes.count
        if self.isFiltered {
            returnValue = filteredEpisodes.count
        }
        return returnValue
    }
    
    func object(atIndex: IndexPath) -> MEpisode {
        var episode = episodes[atIndex.row]
        if self.isFiltered {
            episode = filteredEpisodes[atIndex.row]
        }

        return episode
    }
    
    func title(atIndex index: IndexPath) -> String {
        return object(atIndex: index).title
    }
    
    func subTitle(atIndex index: IndexPath) -> String {
        return object(atIndex: index).description
    }
    
    func imageURL(atIndex index: IndexPath) -> URL {
        return object(atIndex: index).smallArtwork!

    }

}
