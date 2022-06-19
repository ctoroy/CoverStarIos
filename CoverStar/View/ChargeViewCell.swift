//
//  chargeViewCell.swift
//  CoverStar
//
//  Created by taehan park on 2022/06/05.
//

import UIKit
import RxSwift

class ChargeViewCell: UITableViewCell {
    
    static let identifier : String = "ChargeViewCell"

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
        self.btnNext.layer.cornerRadius = 2;
        self.btnNext.layer.borderWidth = 1;
        self.btnNext.layer.borderColor = UIColor(named: "anychat_pink")?.cgColor
        
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
            lblTitle.text = "3,000STAR(3,900원)"
        case 1:
            lblTitle.text = "9,000STAR(8,900원)"
        case 2:
            lblTitle.text = "15,000STAR(14,000원)"
        default:
            lblTitle.text = ""
        }
    }
    
}


