//
//  ViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 17.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let logStatus = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        printFuncName(logStatus)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        printFuncName(logStatus)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        printFuncName(logStatus)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        printFuncName(logStatus)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        printFuncName(logStatus)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        
        printFuncName(logStatus)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        
        printFuncName(logStatus)
    }
    
    private func printFuncName(_ logStatus: Bool, funcName: String = #function) {
        if logStatus {
            print(funcName)
        }
    }
}

