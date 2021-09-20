//
//  ViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 17.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let showLogStatus = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        printFuncName(showLogStatus)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        printFuncName(showLogStatus)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        printFuncName(showLogStatus)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        printFuncName(showLogStatus)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        printFuncName(showLogStatus)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        
        printFuncName(showLogStatus)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        
        printFuncName(showLogStatus)
    }
    
    private func printFuncName(_ logStatus: Bool, funcName: String = #function) {
        if logStatus {
            print(funcName)
        }
    }
}

