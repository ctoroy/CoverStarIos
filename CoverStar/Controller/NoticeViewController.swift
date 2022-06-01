//
//  MainViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/04/19.
//

import UIKit

class NoticeViewController: UIViewController {
    
    @IBOutlet weak var tblNotice: LoadMoreTableView!
    
    @IBOutlet weak var bBtnBack: UIBarButtonItem!
    
    var noticeList : [NoticeInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        bBtnBack.action = #selector(backButtonPressed(sender:))
        setupLoadMoreTableViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblNotice.reload()
        
    }
    
        func setupLoadMoreTableViews(){
            
            //Load Data
            tblNotice.setContentInset(with: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
            tblNotice.onLoadData = {
                page,completed in
                
                self.noticeList.removeAll()
                
                popupManager.showLoadingView()
                
                
                httpTool.loadNoticeList() { (succeed, noticeList, resultInfo) in
                        
                        popupManager.hideLoadingView()
                        if succeed {
                                self.noticeList.append(contentsOf: noticeList)
                                self.tblNotice.dataSource = [self.noticeList]
                        }
                        
                        completed()
                    }
                
            }
        
        
        let bundle = Bundle(for: type(of: self))
        
        //Regist Cells
            tblNotice.register(UINib(nibName: "NoticeCell", bundle: bundle), forCellReuseIdentifier: "NoticeCell")
        
        //Num of row
            tblNotice.numberOfRowsInSection = {
            section in
            
            print("self.tableView.dataSource[section].count  : \(self.tblNotice.dataSource[section].count)")
            
            return self.tblNotice.dataSource[section].count
        }
        
        //Cell
            tblNotice.cellForIndex = {
            tableView, indexPath in
            
            if indexPath.section == 0 {
                
                if(indexPath.count > 0){
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeCell") as? NoticeCell {
                        let notice = self.noticeList[indexPath.row]
                        cell.notice = notice
                        
                        return cell
                    }
                }
            }
            
            return UITableViewCell()
        }
        
        //Select
            tblNotice.onSelect = {
            indexPath in
            
//            if !UserInfoManager.manager.isLogined {
//                let alert = UIAlertController(title: "", message: "로그인 후 이용가능합니다. \n로그인 하시겠습니까?", preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "취소", style: .default, handler: { (_) in
//
//                }))
//
//                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (_) in
//                    self.showLoginVC(complete: {
//                        succeed in
//                        if succeed {
//                            return
//                        }
//
//                    })
//                }))
//
//                self.present(alert, animated: true, completion: nil)
                
//            }else{
//
//                if let cast = self.tableView.dataSource[indexPath.section][indexPath.row] as? CastInfo {
//                    if cast.castType == 0 {
//                        let watchVC = self.viewController(identifier: "WatchCastViewController") as! WatchCastViewController
//
//                        watchVC.cast = cast
//
//                        self.navigationController?.pushViewController(watchVC, animated: true)
//                    }else {
//                        let watchVC = self.viewController(identifier: "WatchVODViewController") as! WatchVODViewController
//
//                        watchVC.cast = cast
//
//                        self.navigationController?.pushViewController(watchVC, animated: true)
//                    }
//                }
            }
        }
        
        @objc func backButtonPressed(sender: UIBarButtonItem) {
            self.presentingViewController?.dismiss(animated: true, completion:nil)
        }

    //MARK: - Data
    private func reload() {
        self.noticeList = []
        
        tblNotice.reload()
    }


}
