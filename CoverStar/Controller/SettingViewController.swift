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
        
        let nibName = String(describing: SettingViewCell.self)
        sampleTableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        
        bBtnBack.action = #selector(backButtonPressed(sender:))
        
        sampleTableView.isScrollEnabled = false
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("dddddddddd0")
            self.performSegue(withIdentifier: "settingToMyInfo", sender: nil)
        case 1:
            print("dddddddddd1")
            self.performSegue(withIdentifier: "settingToNotice", sender: nil)
        case 2:
            print("dddddddddd2")
            self.performSegue(withIdentifier: "settingToNoti", sender: nil)
        case 3:
            print("dddddddddd3")
        case 4:
            let alert = UIAlertController(title: "로그아웃 확인", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
            
            let cancelAction: UIAlertAction

            cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
            
            let OKAction = UIAlertAction(title: "확인", style: .default) {
                (action:UIAlertAction!) in
                appData.set("", forKey: "userID")
                appData.set("", forKey: "userPw")
                // Code in this block will trigger when OK button tapped.
                print("Ok button tapped");
                self.performSegue(withIdentifier: "settingToIntro", sender: nil)
                }
            
            // add an action (button)
            alert.addAction(cancelAction)
            alert.addAction(OKAction)
            // show the alert
            self.present(alert, animated: true, completion: nil)
        default:
            print("ddddddddddD")
        }
    }
}
 
extension SettingViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let SettingViewCell = tableView.dequeueReusableCell(withIdentifier: SettingViewCell.identifier) as? SettingViewCell else {return UITableViewCell ()}
        
        SettingViewCell.setNumber(num: indexPath.row)
        
        return SettingViewCell
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
