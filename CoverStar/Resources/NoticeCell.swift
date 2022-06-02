//
//  NoticeCell.swift
//  CoverStar
//
//  Created by taehan park on 2022/06/02.
//

import UIKit
import Kingfisher

class NoticeCell: UITableViewCell {
    
    
    @IBOutlet weak var txtNotice: UITextView!
    @IBOutlet weak var imageNotice: UIImageView!
    @IBOutlet weak var btnUpDown: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    var notice : NoticeInfo = NoticeInfo() {
        didSet {
            udpateContent()
        }
    }
    
    private func udpateContent() {
        
        DispatchQueue.main.async {
            guard let url = URL(string: self.notice.thumbnail) else { return }
            self.imageNotice.kf.setImage(with: url)
            
            self.lblTitle.text = self.notice.title
            self.txtNotice.text = self.notice.content
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
    }
    
}
