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
    
    
    var episodes: [MEpisode] = [MEpisode]()
    
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
    
    func hasData() -> Bool {
        return (episodes.count != 0)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return episodes.count
    }
    
    func object(atIndex: IndexPath) -> MEpisode {
        return episodes[atIndex.row]
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
