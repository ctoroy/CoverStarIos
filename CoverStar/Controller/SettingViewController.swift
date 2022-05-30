//
//  SettingViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/05/29.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var sampleTableView: UITableView!
    {
            didSet{
                sampleTableView.delegate = self
                sampleTableView.dataSource = self
                sampleTableView.prefetchDataSource = self
                sampleTableView.separatorInset = .zero
            }
        }
    @IBOutlet weak var bBtnBack: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bBtnBack.action = #selector(backButtonPressed(sender:))
    }
    
    @objc func backButtonPressed(sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
}

extension SettingViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
      print("Will Display Cell : \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView,
                   didEndDisplaying cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
      print("Did End Display Cell : \(indexPath.row)")
    }
}
 
extension SettingViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sampleCell = tableView.dequeueReusableCell(withIdentifier: SettingViewCell.identifier) as? SettingViewCell else {return UITableViewCell ()}
        
        sampleCell.setNumber(num: indexPath.row)
        
        return sampleCell
    }
    
    
}
 
extension SettingViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView,
                 prefetchRowsAt indexPaths: [IndexPath]) {
    print("prefetch : \(indexPaths)")
  }
  
  func tableView(_ tableView: UITableView,
                 cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    print("cancelPrefetch : \(indexPaths)")
  }
}
