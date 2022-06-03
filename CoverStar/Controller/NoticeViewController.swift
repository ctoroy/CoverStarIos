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
