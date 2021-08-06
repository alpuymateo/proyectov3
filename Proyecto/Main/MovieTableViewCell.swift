//
//  MovieTableViewCell.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 27/7/21.
//

import UIKit
class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var MovieLabel: UILabel!
    @IBOutlet weak var MovieCollection: UICollectionView!
    weak var cellDelegate: MovieCollectionViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
        let nib: UINib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        self.MovieCollection.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        let nib2: UINib = UINib(nibName: "TapMoreCollectionViewCell", bundle: nil)
        self.MovieCollection.register(nib2, forCellWithReuseIdentifier: "TapMoreCollectionViewCell")
        MovieCollection.delegate = self
        MovieCollection.dataSource = self
        self.MovieCollection.isPagingEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
          }
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        
    }
}

extension MovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.item < 10){
            let cell = collectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell
            self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
        } else{
            let cell = collectionView.cellForItem(at: indexPath) as? TapMoreCollectionViewCell
            self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell.init()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    }
protocol MovieCollectionViewCellDelegate: AnyObject {
    func collectionView(collectionviewcell: MovieCollectionViewCell?, index: Int, didTappedInTableViewCell: MovieTableViewCell)
    func collectionView(collectionviewcell: TapMoreCollectionViewCell?, index: Int, didTappedInTableViewCell: MovieTableViewCell)
}

