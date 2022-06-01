//
//  NoticeCell.swift
//  CoverStar
//
//  Created by taehan park on 2022/06/02.
//
import UIKit
import Kingfisher

class NoticeCell: UITableViewCell {
    
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var imgNotice: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    var notice : NoticeInfo = NoticeInfo() {
        didSet {
            udpateContent()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func udpateContent() {
        //Image Area
        self.imgNotice.kf.setImage(
            with: URL(string: notice.thumbnail),
            placeholder: nil,
            options: [.transition(.fade(1.2))],
            completionHandler: nil
          )
        
        //Info Area
        self.title.text = notice.title
        self.content.text = notice.content
    }
}
