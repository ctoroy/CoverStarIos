//
//  pointChargeViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/06/05.
//

import UIKit

class pointChargeViewController: UIViewController {
    
    @IBOutlet weak var lblPoint: UILabel!
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
        
        let nibName = String(describing: ChargeViewCell.self)
        sampleTableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        
        bBtnBack.action = #selector(backButtonPressed(sender:))
        
        sampleTableView.isScrollEnabled = false
    }
    
    @objc func backButtonPressed(sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        popupManager.showLoadingView()
        
        httpTool.getCurCoin(userID: Static.userId) { (succeed, resultInfo) in
        
            popupManager.hideLoadingView()
        
            if succeed {
                print("my coin =\(Static.curCoin)")
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal

                let result = numberFormatter.string(from: NSNumber(value: Static.curCoin))!
                self.lblPoint.text = "\(result)"
            }
        }
    }
}

extension pointChargeViewController : UITableViewDelegate
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
//            self.performSegue(withIdentifier: "settingToMyInfo", sender: nil)
        case 1:
            print("dddddddddd1")
//            self.performSegue(withIdentifier: "settingToNotice", sender: nil)
        case 2:
            print("dddddddddd2")
//            self.performSegue(withIdentifier: "settingToNoti", sender: nil)
        default:
            print("ddddddddddD")
        }
    }
}
 
extension pointChargeViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let ChargeViewCell = tableView.dequeueReusableCell(withIdentifier: ChargeViewCell.identifier) as? ChargeViewCell else {return UITableViewCell ()}
        
        ChargeViewCell.setNumber(num: indexPath.row)
        
        return ChargeViewCell
    }
    
    
}
 
extension pointChargeViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView,
                 prefetchRowsAt indexPaths: [IndexPath]) {
    print("prefetch : \(indexPaths)")
  }
  
  func tableView(_ tableView: UITableView,
                 cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    print("cancelPrefetch : \(indexPaths)")
  }
}
