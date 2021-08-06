//
//  CategoryMovieModel.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 26/7/21.
//

import Foundation
class CategoryMovieModel {
    var Genre: Genre
    var Movies: [Movie]
    
    init(Genre: Genre, Movies:[Movie]) {
        self.Genre = Genre
        self.Movies = Movies
    }
}
