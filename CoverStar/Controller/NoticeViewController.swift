//
//  MainViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/04/19.
//

import UIKit

class NoticeViewController: UIViewController {
    
    @IBOutlet weak var tblNotice: UITableView!
    {
            didSet{
                tblNotice.delegate = self
                tblNotice.dataSource = self
                tblNotice.prefetchDataSource = self
                tblNotice.separatorInset = .zero
            }
        }
    @IBOutlet weak var bBtnBack: UIBarButtonItem!
    
    var noticeList : [NoticeInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = String(describing: NoticeCell.self)
        tblNotice.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        tblNotice.isScrollEnabled = true
        
        bBtnBack.action = #selector(backButtonPressed(sender:))
//        setupLoadMoreTableViews()
        
        self.noticeList.removeAll()
        popupManager.showLoadingView()
        
        httpTool.loadNoticeList() { (succeed, noticeList, resultInfo) in
                
            popupManager.hideLoadingView()
            if succeed {
                self.noticeList.append(contentsOf: noticeList)
                print("self.contestList count=\(self.noticeList.count)")
                self.tblNotice.reloadData()
                let indexPath = IndexPath(row: 0, section: 0)
                self.tblNotice.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            print("contestList count=\(self.noticeList.count)")
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }        
    
//        func setupLoadMoreTableViews(){
//
//            //Load Data
//            tblNotice.setContentInset(with: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
//            tblNotice.onLoadData = {
//                page,completed in
//
//                self.noticeList.removeAll()
//
//                popupManager.showLoadingView()
//
//
//                httpTool.loadNoticeList() { (succeed, noticeList, resultInfo) in
//
//                    popupManager.hideLoadingView()
//                    if succeed {
//                            self.noticeList.append(contentsOf: noticeList)
//                            self.tblNotice.dataSource = [self.noticeList]
//                    }
//
//                    completed()
//                }
//
//            }
//
//
//        let bundle = Bundle(for: type(of: self))
//
//        //Regist Cells
//            tblNotice.register(UINib(nibName: "NoticeCell", bundle: bundle), forCellReuseIdentifier: "NoticeCell")
//
//        //Num of row
//            tblNotice.numberOfRowsInSection = {
//            section in
//            print("self.tableView.dataSource[section].count  : \(self.tblNotice.dataSource[section].count)")
//
//            return self.tblNotice.dataSource[section].count
//        }
//
//        //Cell
//            tblNotice.cellForIndex = {
//            tableView, indexPath in
//
//                if indexPath.section == 0 {
//
//                    if(indexPath.count > 0){
//                        if let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeCell") as? NoticeCell {
//                            let notice = self.noticeList[indexPath.row]
//                            cell.notice = notice
//
//                            return cell
//                        }
//                    }
//                }
//
//            return UITableViewCell()
//            }
//
//        //Select
//       tblNotice.onSelect = {
//            indexPath in
//
//            }
//        }
//
//
        @objc func backButtonPressed(sender: UIBarButtonItem) {
            self.presentingViewController?.dismiss(animated: true, completion:nil)
        }
//
//    //MARK: - Data
//    private func reload() {
//        self.noticeList = []
//
//        tblNotice.reload()
//    }
}


extension NoticeViewController : UITableViewDelegate
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
        
//        self.performSegue(withIdentifier: "oldToDetail", sender: nil)
        
//        switch indexPath.row {
//        case 0:
//            print("dddddddddd0")
//            self.performSegue(withIdentifier: "settingToMyInfo", sender: nil)
//        case 1:
//            print("dddddddddd1")
//            self.performSegue(withIdentifier: "settingToNotice", sender: nil)
//        case 2:
//            print("dddddddddd2")
//            self.performSegue(withIdentifier: "settingToNoti", sender: nil)
//        case 3:
//            print("dddddddddd3")
//        case 4:
//            let alert = UIAlertController(title: "로그아웃 확인", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
//
//            let cancelAction: UIAlertAction
//
//            cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
//
//            let OKAction = UIAlertAction(title: "확인", style: .default) {
//                (action:UIAlertAction!) in
//                appData.set("", forKey: "userID")
//                appData.set("", forKey: "userPw")
//                // Code in this block will trigger when OK button tapped.
//                print("Ok button tapped");
//                self.performSegue(withIdentifier: "settingToIntro", sender: nil)
//                }
//
//            // add an action (button)
//            alert.addAction(cancelAction)
//            alert.addAction(OKAction)
//            // show the alert
//            self.present(alert, animated: true, completion: nil)
//        default:
//            print("ddddddddddD")
//        }
    }
}
 
extension NoticeViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("self.castList count table=\(self.noticeList.count)")
        return self.noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let NoticeCell = tableView.dequeueReusableCell(withIdentifier: NoticeCell.identifier) as? NoticeCell else {return UITableViewCell ()}
        
        NoticeCell.setData(profileImage: noticeList[indexPath.row].thumbnail, castTitle: noticeList[indexPath.row].title, nickName: noticeList[indexPath.row].content)
        
        return NoticeCell
    }
    
    
}
 
extension NoticeViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView,
                 prefetchRowsAt indexPaths: [IndexPath]) {
    print("prefetch : \(indexPaths)")
  }
  
  func tableView(_ tableView: UITableView,
                 cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    print("cancelPrefetch : \(indexPaths)")
  }
}
