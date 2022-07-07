//
//  bsetPlayViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/07/07.
//

import UIKit

class bestPlayViewController: UIViewController {
    @IBOutlet weak var bBtnHome: UIBarButtonItem!
    @IBOutlet weak var bBtnSearch: UIBarButtonItem!
    @IBOutlet weak var btnSort: UIButton!
    @IBOutlet weak var bBtnNotice: UIBarButtonItem!
    @IBOutlet weak var tblMain: UITableView!
    {
            didSet{
                tblMain.delegate = self
                tblMain.dataSource = self
                tblMain.prefetchDataSource = self
                tblMain.separatorInset = .zero
            }
        }
    
    var castList : [CastInfo] = []
    var contestList : [ContestInfo] = []
    var castStartDate = ""
    var castEndDate = ""
    var category = ""
    var castPath = ""
    var profileIamge = ""
    var castType = ""
    var sortMid = ""
    var sortSmall = ""
    var location = ""
    var store = ""
    var product = ""
    var sortOrder = "2"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bBtnHome.action = #selector(homeButtonPressed(sender:))
        bBtnNotice.action = #selector(noticeButtonPressed(sender:))
        bBtnSearch.action = #selector(searchButtonPressed(sender:))
        
        self.getData()
        
//        self.showAlertController(style: UIAlertController.Style.actionSheet,isFirst: true)
        
        let nibName = String(describing: MainViewCell.self)
        tblMain.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        tblMain.isScrollEnabled = true
    }

    
    func showAlertController(style: UIAlertController.Style) {
            let alertController: UIAlertController
            alertController = UIAlertController(title: "정렬 방법", message: "", preferredStyle: style)

            let okAction: UIAlertAction

            okAction = UIAlertAction(title: "인기순", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
                self.btnSort.setTitle("인기순  ", for: .normal)
                self.sortOrder = "0"
                print("Ok button tapped");
                self.getData()
            })
            okAction.setValue(UIColor(named: "anychat_pink"), forKey: "titleTextColor")

            let cancelAction: UIAlertAction

            cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
            cancelAction.setValue(UIColor(named: "anychat_pink"), forKey: "titleTextColor")

            alertController.addAction(okAction)
            alertController.addAction(cancelAction)

            self.present(alertController, animated: true, completion: { print("Alert controller shown") })
        
        let handler: (UIAlertAction) -> Void
                handler = { (action: UIAlertAction) in
                    print("action pressed \(action.title ?? "")")
                    if(action.title == "조회순"){
                        self.btnSort.setTitle("조회순  ", for: .normal)
                        self.sortOrder = "1"
                        self.getData()
                    }else{
                        self.btnSort.setTitle("최신순  ", for: .normal)
                        self.sortOrder = "2"
                        self.getData()
                    }
                }

                let someAction: UIAlertAction
                someAction = UIAlertAction(title: "조회순", style: UIAlertAction.Style.default, handler: handler)
        
        someAction.setValue(UIColor(named: "anychat_pink"), forKey: "titleTextColor")

        let anotherAction: UIAlertAction
                anotherAction = UIAlertAction(title: "최신순", style: UIAlertAction.Style.default, handler: handler)

                alertController.addAction(someAction)
                alertController.addAction(anotherAction)
        
        anotherAction.setValue(UIColor(named: "anychat_pink"), forKey: "titleTextColor")
        
        }
    @IBAction func btnSort_click(_ sender: Any) {
        
        self.showAlertController(style: UIAlertController.Style.actionSheet)
    }
    
//    func showAlertController(style: UIAlertController.Style, isFirst:Bool) {
//
//        self.contestList.removeAll()
//        popupManager.showLoadingView()
//
//        httpTool.loadContestLastList() { (succeed, contestList, resultInfo) in
//
//            popupManager.hideLoadingView()
//            if succeed {
//                self.contestList.append(contentsOf: contestList)
//                print("self.contestList count=\(self.contestList.count)")
//            }
//
//            let alertController = UIAlertController(title: "경연 목록", message: "선택해 주세요.", preferredStyle: .actionSheet)
//
//            print("contestList count=\(self.contestList.count)")
//
//            for (index, item) in  self.contestList.enumerated(){
//                    print("alert add2\(item.contestTitle)")
//                if index == 0{
//                    self.btnFilter.setTitle(item.contestTitle, for: .normal)
//                }
//                    let superbutton = UIAlertAction(title: item.contestTitle , style: .default, handler: { (action) in
//                        print("alert add\(item.contestTitle)")
//                        self.btnFilter.setTitle(action.title, for: .normal)
//
//                        self.castStartDate = item.contestStartDate
//                        self.castEndDate = item.contestEndDate
//                        self.category = item.contestType
//                        self.castPath = "\(item.contestId)"
//                        self.castType = item.contestType
//                        self.sortMid = item.contestAward
//                        self.sortSmall = item.contestTitle
//                        self.store = item.contestShotDate
//
//                        self.getData(contestId: self.castPath, sort: self.sortOrder)
//
//                    })
//
//                    self.castStartDate = item.contestStartDate
//                    self.castEndDate = item.contestEndDate
//                    self.category = item.contestType
//                    self.castPath = "\(item.contestId)"
//                    self.castType = item.contestType
//                    self.sortMid = item.contestAward
//                    self.sortSmall = item.contestTitle
//                    self.store = item.contestShotDate
//
//                    print("2self.castPath=\(self.castPath)")
//                    self.btnFilter.setTitle(self.sortSmall, for: .normal)
//
//                    superbutton.setValue(UIColor(named: "anychat_pink"), forKey: "titleTextColor")
//                    alertController.addAction(superbutton)
//                }
//            if (isFirst == false){
//                let cancelAction: UIAlertAction
//                cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
//                cancelAction.setValue(UIColor(named: "anychat_pink"), forKey: "titleTextColor")
//                alertController.addAction(cancelAction)
//                self.present(alertController, animated: true, completion: { print("Alert controller shown") })
//                return
//            }
//
//            print("self.castPath=\(self.castPath)")
//            self.getData(contestId: self.castPath, sort: self.sortOrder)
//        }
//    }
    
    func getData() {
        
        self.castList.removeAll()
        popupManager.showLoadingView()
        
        httpTool.getStarList() { (succeed, castList, resultInfo) in
                
            popupManager.hideLoadingView()
            if succeed {
                self.castList.append(contentsOf: castList)
                print("self.castList count=\(self.castList.count)")
                self.tblMain.reloadData()
                let indexPath = IndexPath(row: 0, section: 0)
                self.tblMain.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
    }

    @objc func homeButtonPressed(sender: UIBarButtonItem) {
//        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    
    @objc func noticeButtonPressed(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "bestToNotice", sender: nil)
    }
    
    @objc func searchButtonPressed(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "bestToSearch", sender: nil)
    }
    
    
//    @IBAction func btnFilter_click(_ sender: Any) {
//        self.showAlertController(style: UIAlertController.Style.actionSheet,isFirst: false)
//    }
}

extension bestPlayViewController : UITableViewDelegate
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
        
        self.performSegue(withIdentifier: "bestToDetail", sender: nil)
        
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
 
extension bestPlayViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("self.castList count table=\(self.castList.count)")
        return self.castList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let MainViewCell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.identifier) as? MainViewCell else {return UITableViewCell ()}
        
        MainViewCell.setData(profileImage: castList[indexPath.row].profileImage, castTitle: castList[indexPath.row].castTitle, nickName: castList[indexPath.row].nickName, logoImage: castList[indexPath.row].logoImage)
        
        return MainViewCell
    }
    
    
}
 
extension bestPlayViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView,
                 prefetchRowsAt indexPaths: [IndexPath]) {
    print("prefetch : \(indexPaths)")
  }
  
  func tableView(_ tableView: UITableView,
                 cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    print("cancelPrefetch : \(indexPaths)")
  }
}

