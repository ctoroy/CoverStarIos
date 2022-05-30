//
//  JoinViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/05/29.
//

import UIKit

class JoinViewController: UIViewController {
    
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var btnJoin: UIButton!
    @IBOutlet weak var txtMySay: UITextView!
    @IBOutlet weak var txtVodLink: UITextField!
    @IBOutlet weak var txtSubTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlertController(style: UIAlertController.Style) {
            let alertController: UIAlertController
            alertController = UIAlertController(title: "조회 방법", message: "", preferredStyle: style)

            let okAction: UIAlertAction

            okAction = UIAlertAction(title: "인기순", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
                self.btnFilter.setTitle("인기순  ", for: .normal)
                print("Ok button tapped");
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
                        self.btnFilter.setTitle("조회순  ", for: .normal)
                    }else{
                        self.btnFilter.setTitle("최신순  ", for: .normal)
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
    
    @IBAction func btnFilter_click(_ sender: Any) {
        self.showAlertController(style: UIAlertController.Style.actionSheet)
    }
}
