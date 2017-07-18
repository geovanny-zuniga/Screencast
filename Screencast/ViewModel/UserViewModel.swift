//
//  LoginViewModel.swift
//  Screencast
//
//  Created by Geovanny Zuniga on 17/7/17.
//  Copyright © 2017 SOIN. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import Moya_ObjectMapper
import SystemConfiguration

public enum LoginError {
    case notError
    case emptyUserName
    case emptyPassword
    
    func getText() -> String {
        var errorMessage: String = ""
        switch self {
        case .emptyUserName:
            errorMessage = "Ingrese el nombre de usuario"
        case .emptyPassword:
            errorMessage = "Ingrese la contraseña"
        default:
            errorMessage = ""
        }
        return errorMessage
    }
    
    func hasError() -> Bool {
        return self != .notError
    }
}
class UserViewModel: NSObject {
    
    private var user: MUser?
    var disposeBag = DisposeBag()
    
    
    var beginLoadingSignal = PublishSubject<Any?>()
    var endLoadingSignal = PublishSubject<Any?>()
    var loginSuccess = PublishSubject<Any?>()
    var errorSignal = PublishSubject<String>()

    
    func validate(userName: String, password: String) -> LoginError {
        var error: LoginError = .notError
        if userName.isEmpty {
            error = .emptyUserName
        }
        else if password.isEmpty {
            error =  .emptyPassword
        }
        return error
    }
    
    func login(userName: String, password: String, provider: RxMoyaProvider<ScreencastApi> =  RxMoyaProvider<ScreencastApi>()
) {
        beginLoadingSignal.onNext(nil)
        //let provider = RxMoyaProvider<ScreencastApi>()
        let getUser = ScreencastApi.login(userName, password)
        provider.request(getUser)
            .mapObject(MUser.self)
            .subscribe { [weak self] event -> Void  in
                if let strongSelf = self {
                    switch event {
                    case .next(let userObject):
                        strongSelf.user = userObject
                        strongSelf.loginSuccess.onNext(nil)
                        strongSelf.endLoadingSignal.onNext(nil)
                    case .error(let error):
                        print(error)
                        strongSelf.errorSignal.onNext(error.localizedDescription)
                        strongSelf.endLoadingSignal.onNext(nil)
                    default:
                        break
                    }
                    
                }
            }.addDisposableTo(disposeBag)
        
    }
    
}
