//
//  ViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 17.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let showLog = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        printFuncName(showLog)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        printFuncName(showLog)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        printFuncName(showLog)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        printFuncName(showLog)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        printFuncName(showLog)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        
        printFuncName(showLog)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        
        printFuncName(showLog)
    }
    
    private func printFuncName(_ logStatus: Bool, funcName: String = #function) {
        if logStatus {
            print(funcName)
        }
    }
}

