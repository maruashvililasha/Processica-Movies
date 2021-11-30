//
//  MovieDetailsViewController.swift
//  Processica Movies
//
//  Created by Lasha Maruashvili on 30.11.21.
//

import UIKit
import Core

class MovieDetailsViewController: PViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var overViewTextView: UITextView!

    var movie: MovieEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // Image
        let placeHolder = UIImage(named: "Placeholder")
        if let moviePoster = movie.poster, let posterURL = URL(string: moviePoster) {
            posterImageView.kf.setImage(with: posterURL, placeholder: placeHolder)
        } else {
            posterImageView.image = placeHolder
        }
        // Background Image
        let backgroundImagePlaceHolder = UIImage(named: "PBackrground")
        if let backgroundImage = movie.background, let backgroundImageURL = URL(string: backgroundImage) {
            backgroundImageView.kf.setImage(with: backgroundImageURL, placeholder: backgroundImagePlaceHolder)
        } else {
            backgroundImageView.image = backgroundImagePlaceHolder
        }
        backgroundImageView.image = backgroundImagePlaceHolder
        self.titleLabel.text = movie.name
        self.voteCountLabel.text = "\(movie.voteCount)"
        self.voteAverageLabel.text = "\(movie.voteAverage)"
        self.overViewTextView.text = movie.overview
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
