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
      print("\n============ ๐ deinit ============\n")
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setNumber(num: Int)
    {
        print("String(num)=" + String(num))

        switch num {
        case 0:
            lblTitle.text = "๊ฐ์ธ ์ ๋ณด"
        case 1:
            lblTitle.text = "๊ณต์ง ์ฌํญ"
        case 2:
            lblTitle.text = "์๋ฆผ"
        case 3:
            lblTitle.text = "๋ฒ์  (" + Static.appVer + ")"
            btnNext.isHidden = true
        case 4:
            lblTitle.text = "๋ก๊ทธ์์"
            btnNext.isHidden = true
        default:
            lblTitle.text = ""
        }
    }
    
}

