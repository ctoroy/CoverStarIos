//
//  NoticeCell.swift
//  CoverStar
//
//  Created by taehan park on 2022/06/02.
//

import UIKit
import RxSwift
import Kingfisher

class NoticeCell: UITableViewCell {
    
    static let identifier : String = "NoticeCell"
    
    var bag = DisposeBag()
    
    @IBOutlet weak var txtNotice: UITextView!
    @IBOutlet weak var imageNotice: UIImageView!
    @IBOutlet weak var btnUpDown: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
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
    
    func setData(profileImage: String,castTitle:String,nickName:String)
    {
        guard let url = URL(string: profileImage) else { return }
        self.imageNotice.kf.setImage(
            with: url,
            placeholder: UIImage(named: "icn_logo_color"),
            completionHandler: nil)
        self.lblTitle.text = castTitle
        self.txtNotice.text = nickName
//        self.lblSinger.text = logoImage

    }
    
//    var notice : NoticeInfo = NoticeInfo() {
//        didSet {
//            udpateContent()
//        }
//    }
//
//    private func udpateContent() {
//
//        DispatchQueue.main.async {
//            guard let url = URL(string: self.notice.thumbnail) else { return }
//            self.imageNotice.kf.setImage(with: url)
//
//            self.lblTitle.text = self.notice.title
//            self.txtNotice.text = self.notice.content
//        }
//
//    }
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func draw(_ rect: CGRect) {
//    }
    
}
