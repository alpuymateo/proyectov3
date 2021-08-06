//
//  MovieModel.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 25/7/21.
//

import Foundation
import ObjectMapper
class Movie:Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.adult <- map["adult"]
        self.backdrop_path <- map["backdrop_path"]
        self.genre_id <- map["genre_id"]
        self.id <- map["id"]
        self.original_language <- map["original_language"]
        self.original_title <- map["original_title"]
        self.overview <- map["overview"]
        self.popularity <- map["popularity"]
        self.poster_path <- map["poster_path"]
        self.release_date <- map["release_date"]
        self.title <- map["title"]
        self.video <- map["video"]
        self.vote_average <- map["vote_average"]
        self.vote_count <- map["vote_count"]
        
    }
    
    var adult: Bool!
    var backdrop_path: String!
    var genre_id: [Int]!
    var id: Int!
    var original_language: String!
    var original_title: String!
    var overview: String!
    var popularity: Double!
    var poster_path: String!
    var release_date: String!
    var title: String!
    var video: Bool!
    var vote_average: Double!
    var vote_count: Int!
    
    
    init(adult: Bool, backdrop_path: String,genre_ids: [Int], id: Int, original_language: String, original_title: String, overview: String, popularity: Double, poster_path: String, release_date: String, title: String, video: Bool, vote_average: Double, vote_count: Int  ) {
        self.adult = adult
        self.backdrop_path = backdrop_path
        self.genre_id = genre_ids
        self.id = id
        self.original_language = original_language
        self.original_title = original_title
        self.overview = overview
        self.popularity = popularity
        self.poster_path = poster_path
        self.release_date = release_date
        self.title = title
        self.video = video
        self.vote_average = vote_average
        self.vote_count = vote_count
    }
}

