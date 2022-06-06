//
//  MainCell.swift
//  CoverStar
//
//  Created by taehan park on 2022/06/06.
//

import UIKit
import RxSwift
import Kingfisher

class MainViewCell: UITableViewCell {
    
    static let identifier : String = "MainViewCell"
    
    var bag = DisposeBag()
    
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSinger: UILabel!
    
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
    
    func setData(profileImage: String,castTitle:String,nickName:String,logoImage:String)
    {
        guard let url = URL(string: profileImage) else { return }
        self.imgThumbnail.kf.setImage(
            with: url,
            placeholder: UIImage(named: "icn_logo_color"),
            completionHandler: nil)
        self.lblTitle.text = castTitle
        self.lblName.text = nickName
        self.lblSinger.text = logoImage

    }
    
}
