//
//  MovieCollectionViewCell.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 27/7/21.
//

import UIKit
import Kingfisher
class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var MovieCollectionMovieId: UILabel!
    @IBOutlet weak var MovieCollectionLabel: UILabel!
    @IBOutlet weak var MovieCollectionImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(textLabel:String,movieId: String, urlImage: URL ){
        self.MovieCollectionImage.kf.setImage(with: urlImage)
        self.MovieCollectionLabel.text = textLabel
        self.MovieCollectionMovieId.text = movieId
    }


}
