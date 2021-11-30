//
//  MoviesTableViewCell.swift
//  Processica Movies
//
//  Created by Lasha Maruashvili on 30.11.21.
//

import UIKit
import Core
import Kingfisher

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with movie: MovieEntity) {
        // Image
        let placeHolder = UIImage(named: "Placeholder")
        if let moviePoster = movie.poster, let posterURL = URL(string: moviePoster) {
            movieImageView.kf.setImage(with: posterURL, placeholder: placeHolder)
        } else {
            movieImageView.image = placeHolder
        }
        // Background Image
        let backgroundImagePlaceHolder = UIImage(named: "PBackrground")
        if let backgroundImage = movie.background, let backgroundURL = URL(string: backgroundImage) {
            backgroundImageView.kf.setImage(with: backgroundURL, placeholder: backgroundImagePlaceHolder)
        } else {
            backgroundImageView.image = backgroundImagePlaceHolder
        }
        self.titleLabel.text = movie.name
        self.voteCountLabel.text = "\(movie.voteCount)"
        self.voteAverageLabel.text = "\(movie.voteAverage)"
    }

}
