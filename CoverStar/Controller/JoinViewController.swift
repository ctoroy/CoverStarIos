//
//  JoinViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/05/29.
//

import UIKit

class JoinViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var btnJoin: UIButton!
    @IBOutlet weak var txtMySay: UITextView!
    @IBOutlet weak var txtVodLink: UITextField!
    @IBOutlet weak var txtSubTitle: UITextField!
    
    var contestList : [ContestInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
                view.addGestureRecognizer(tap)
        
        txtTitle.delegate = self
        txtVodLink.delegate = self
        txtSubTitle.delegate = self
        
        txtTitle.addDoneButtonToKeyboard(myAction:  #selector(self.txtTitle.resignFirstResponder))
        txtVodLink.addDoneButtonToKeyboard(myAction:  #selector(self.txtVodLink.resignFirstResponder))
        txtSubTitle.addDoneButtonToKeyboard(myAction:  #selector(self.txtSubTitle.resignFirstResponder))
        
        let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        txtMySay.layer.borderColor = color
        txtMySay.layer.borderWidth = 0.5
        txtMySay.layer.cornerRadius = 5
    }
    
    func showAlertController(style: UIAlertController.Style) {
        
        
        self.contestList.removeAll()
        popupManager.showLoadingView()
        
        httpTool.loadContestList() { (succeed, contestList, resultInfo) in
                
            popupManager.hideLoadingView()
            if succeed {
                self.contestList.append(contentsOf: contestList)
            }
        }
        
        let alertController = UIAlertController(title: "Action Sheet", message: "List of Superheroes", preferredStyle: .actionSheet)

            for item in contestList{
                print("alert add2\(item.contestTitle)")
                let superbutton = UIAlertAction(title: item.contestTitle , style: .default, handler: { (action) in
                    print("alert add\(item.contestTitle)")
                })
                alertController.addAction(superbutton)
            }

        self.present(alertController, animated: true, completion: { print("Alert controller shown") })
        
//        let alertController: UIAlertController
//        alertController = UIAlertController(title: "경연/이벤트 목록", message: "", preferredStyle: style)
//
//            let okAction: UIAlertAction
//
//            okAction = UIAlertAction(title: "인기순", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
//                self.btnFilter.setTitle("인기순  ", for: .normal)
//                print("Ok button tapped");
//            })
//            okAction.setValue(UIColor(named: "anychat_pink"), forKey: "titleTextColor")
//
//            let cancelAction: UIAlertAction
//
//            cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
//
//            cancelAction.setValue(UIColor(named: "anychat_pink"), forKey: "titleTextColor")
//
//            alertController.addAction(okAction)
//            alertController.addAction(cancelAction)
//
//            self.present(alertController, animated: true, completion: { print("Alert controller shown") })
//
//        let handler: (UIAlertAction) -> Void
//                handler = { (action: UIAlertAction) in
//                    print("action pressed \(action.title ?? "")")
//                    if(action.title == "조회순"){
//                        self.btnFilter.setTitle("조회순  ", for: .normal)
//                    }else{
//                        self.btnFilter.setTitle("최신순  ", for: .normal)
//                    }
//                }
//
//                let someAction: UIAlertAction
//                someAction = UIAlertAction(title: "조회순", style: UIAlertAction.Style.default, handler: handler)
//
//        someAction.setValue(UIColor(named: "anychat_pink"), forKey: "titleTextColor")
//
//        let anotherAction: UIAlertAction
//                anotherAction = UIAlertAction(title: "최신순", style: UIAlertAction.Style.default, handler: handler)
//
//                alertController.addAction(someAction)
//                alertController.addAction(anotherAction)
//
//        anotherAction.setValue(UIColor(named: "anychat_pink"), forKey: "titleTextColor")
        
        }
    
    @IBAction func btnFilter_click(_ sender: Any) {
        self.showAlertController(style: UIAlertController.Style.actionSheet)
    }
}
