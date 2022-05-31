//
//  foldingCell.swift
//  CoverStar
//
//  Created by taehan park on 2022/05/31.
//

import FoldingCell
import UIKit

class foldingCell: FoldingCell {
    
    var number: Int = 0

    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }

    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}
