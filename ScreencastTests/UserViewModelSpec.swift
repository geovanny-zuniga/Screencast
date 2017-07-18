//
//  UserViewModelSpec.swift
//  Screencast
//
//  Created by Geovanny Zuniga on 18/7/17.
//  Copyright © 2017 SOIN. All rights reserved.
//

import Quick
import Nimble
import XCTest
@testable import Screencast
class UserViewModelSpec: QuickSpec {
    
    override func spec() {
        var userViewModel: UserViewModel!
        beforeEach {
            userViewModel = UserViewModel()
        }
        
        describe("UserViewModel") {
            it("Login hasError with error") {
                let errorEnum = LoginError.emptyUserName
                let hasError = errorEnum.hasError()
                expect(hasError).to(beTrue())
            }
            
            it("Login hasError with not error") {
                let errorEnum = LoginError.notError
                let hasError = errorEnum.hasError()
                expect(hasError).to(beFalse())
            }
            
            it("Login get error text") {
                expect(LoginError.emptyUserName.getText()).to(equal("Ingrese el nombre de usuario"))
                expect(LoginError.emptyPassword.getText()).to(equal("Ingrese la contraseña"))
                expect(LoginError.notError.getText()).to(equal(""))
            }
            
            it("Validate username and password fields") {
                var loginError = userViewModel.validate(userName: "", password: "")
                expect(LoginError.emptyUserName).to(equal(loginError))
                loginError = userViewModel.validate(userName: "juan", password: "")
                expect(LoginError.emptyPassword).to(equal(loginError))
            }
        }
    }
    

}
