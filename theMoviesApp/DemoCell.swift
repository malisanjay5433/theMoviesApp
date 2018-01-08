//
//  DemoCell.swift
//  theMoviesApp
//
//  Created by Sanjay Mali on 09/01/18.
//  Copyright © 2017 Sanjay Mali. All rights reserved.
//


import UIKit
import FoldingCell
class DemoCell: FoldingCell {
    
    @IBOutlet weak var closeNumberLabel: UILabel!
    @IBOutlet weak var openNumberLabel: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var vote_average: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var release_date: UILabel!
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var imageAvtar: UIImageView!
    @IBOutlet weak var descriptionLbl:UILabel!

    
    var number: Int = 0 {
        didSet {
            closeNumberLabel.text = String(number)
            openNumberLabel.text = String(number)
        }
    }
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
}

// MARK: - Actions ⚡️
extension DemoCell {
    
    @IBAction func buttonHandler(_ sender: AnyObject) {
        print("tap")
    }
    
}
