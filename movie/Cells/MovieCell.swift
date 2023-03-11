//
//  MovieCell.swift
//  movie
//
//  Created by dan on 06.03.2023.
//

import UIKit

class MovieCell: UITableViewCell {

    
    @IBOutlet weak var ratingContainerVIew: UIView!
    @IBOutlet weak var overallRatingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    
    public static let identifier: String = "MovieCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        originalTitleLabel.textColor = .white
        originalTitleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        originalTitleLabel.contentMode = .scaleToFill
        originalTitleLabel.numberOfLines = 0
        
        releaseDateLabel.textColor = .white
        releaseDateLabel.font = .systemFont(ofSize: 25, weight: .regular)
        posterImageView.layer.cornerRadius = 8
        posterImageView.layer.masksToBounds = true
        
        ratingContainerVIew.layer.cornerRadius = 27
        ratingContainerVIew.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
