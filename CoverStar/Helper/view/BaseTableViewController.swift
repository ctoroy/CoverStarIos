//
//  BaseTableViewController.swift
//  PopkonAir
//
//  Created by Steven on 27/10/2016.
//  Copyright © 2016 roy. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    //MARK: - Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        
        super.viewWillAppear(animated)
        
        //update Back button display
        if let navi = self.navigationController {
            
            
            let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
            navigationItem.leftBarButtonItem = backButton
            navi.navigationItem.setRightBarButtonItems([], animated: false)
            
            
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override var shouldAutorotate: Bool
    {
        return false
    }
}
