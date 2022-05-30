//
//  TermsCell.swift
//  CellTest
//
//  Created by taehan park on 2022/04/01.
//
import UIKit
import RxSwift

class LegalAgreeCell: UITableViewCell {
    var bag = DisposeBag()

    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lblOption: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bind(_ data: Terms) {
        lblTitle.text = data.title.precomposedStringWithCanonicalMapping // NFD -> NFC

        switch data.type {
        case .main:
            let mandatoryName = data.isMandatory ? "(필수)" : "(선택)"
            lblOption.isHidden = false
            lblOption.text = mandatoryName
            leadingConstraint.constant = 12
            topConstraint.constant = 14
            bottomConstraint.constant = 14
        case .sub:
            lblOption.isHidden = true
            leadingConstraint.constant = 48
            topConstraint.constant = 14
            bottomConstraint.constant = 8
        }
        let checkImageName = data.isAccept ? "circle.fill" : "circle"
        btnCheck.setImage(UIImage(systemName: checkImageName), for: .normal)
    }
}
