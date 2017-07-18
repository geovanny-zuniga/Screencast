//
//  LoginViewController.swift
//  Screencast
//
//  Created by Geovanny Zuniga on 17/7/17.
//  Copyright © 2017 SOIN. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class LoginViewController: UIViewController {
    
    var userViewModel: UserViewModel = UserViewModel()
    
    var disposeBag = DisposeBag()

    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSignals()
        // Do any additional setup after loading the view.
    }
    
    func setUpSignals() {
        userViewModel.loginSuccess.observeOn(MainScheduler.instance).subscribe( onNext: { [weak self] _ in
            if let strongSelf = self {
                strongSelf.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            
        }).addDisposableTo(disposeBag)
        
        userViewModel.beginLoadingSignal.observeOn(MainScheduler.instance).subscribe(onNext: { _ in
            SVProgressHUD.show(withStatus: "Cargando")
            
        }).addDisposableTo(disposeBag)
        
        userViewModel.endLoadingSignal.observeOn(MainScheduler.instance).subscribe(onNext: { _ in
            SVProgressHUD.dismiss()
            
        }).addDisposableTo(disposeBag)
        
        userViewModel.errorSignal.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] error in
            if let strongSelf = self {
                AlertUtil.showAlert(viewController: strongSelf, title: "Error", message: error)
            }

            
        }).addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonLoginPressed(_ sender: Any) {
        let error = userViewModel.validate(userName: userNameText.text!, password: passwordText.text!)
        if error.hasError() {
            AlertUtil.showAlert(viewController: self, title: "Error", message: error.getText())
        }
        else {
            userViewModel.login(userName: userNameText.text!, password: passwordText.text!)
        }
    }
    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/
    

}
