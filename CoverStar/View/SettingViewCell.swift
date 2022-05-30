//
//  SettingViewCell.swift
//  CoverStar
//
//  Created by taehan park on 2022/05/30.
//

import UIKit
import RxSwift

class SettingViewCell: UITableViewCell {
    
    static let identifier : String = "SettingViewCell"

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var bag = DisposeBag()
    
    func getIndexPath() -> Int {
            var indexPath = 0
            
            guard let superView = self.superview as? UITableView else {
                print("superview is not a UITableView - getIndexPath")
                return -1
            }
            
            indexPath = superView.indexPath(for: self)!.row
            return indexPath
        }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    deinit {
      print("\n============ 🔒 deinit ============\n")
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setNumber(num: Int)
    {
        print("String(num)=" + String(num))

        switch num {
        case 0:
            lblTitle.text = "개인 정보"
        case 1:
            lblTitle.text = "공지 사항"
        case 2:
            lblTitle.text = "알림"
        case 3:
            lblTitle.text = "버전 (" + Static.appVer + ")"
            btnNext.isHidden = true
        case 4:
            lblTitle.text = "로그아웃"
            btnNext.isHidden = true
        default:
            lblTitle.text = ""
        }
    }
    
}

