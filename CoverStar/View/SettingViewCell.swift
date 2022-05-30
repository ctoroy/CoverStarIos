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
    
    func getIndexPath() -> Int {
            var indexPath = 0
            
            guard let superView = self.superview as? UITableView else {
                print("superview is not a UITableView - getIndexPath")
                return -1
            }
            
            indexPath = superView.indexPath(for: self)!.row
            return indexPath
        }
    
    override func awakeFromNib() {
      super.awakeFromNib()
      
      print("\n============ 🍏 awakeFromNib ============\n")
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
      
      print("\n============ 👀 prepareForReuse ============\n")
    }
    
    deinit {
      print("\n============ 🔒 deinit ============\n")
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
        // Configure the view for the selected state
    }
    
    func setNumber(num: Int)
    {
        lblTitle.text = String(num)
    }
    
}

