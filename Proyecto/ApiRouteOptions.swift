////
////  ApiRouteOptions.swift
////  Proyecto
////
////  Created by MATEO  ALPUY on 26/7/21.
////
//
import Foundation
import Alamofire

enum catchErrors: Error {
    case invalidPassword
    case insufficientFunds
    case outOfStock
}

enum Router: APIRoute{
    case getSimilars(movie_id: Int)
    case setFavorite( movie_id: Int)
    case getFavorites
    case getMovies(page: Int)
    case getByLetter(letters: String)
    case getSession(request_token: String)
    case getGenreWithPage(genreId: Int,page: Int)
    case getToken
    case getGenre
    case login(username: String,password: String,request_token: String)
    case getMoviesByGenre(genreId: Int)
    func asURLRequest() throws -> URLRequest {
        switch self{
        case .getSimilars(movie_id: let movie_id):
            let url = "movie/\(movie_id)/similar?"
            return try encoded(path: url, params: [:])
        case.setFavorite( movie_id: let movie_id):
            let url = "account/{account_id}/favorite?"
            return try encoded(path: url, params: ["media_type": "movie", "media_id" : movie_id, "favorite": true])
        case .getFavorites:
            let url = "account/{account_id}/favorite/movies?"
            return try encoded(path: url, params: [ :] )
        case .getMovies(page: let page):
            let url = "discover/movie?"
            return try encoded(path: url, params: ["page" : page])
        case .getByLetter(letters: let letter):
            let url="search/movie?"
            return try encoded(path: url, params: ["query" : letter])
        case .getSession(request_token: let session):
            let url = "authentication/session/new?"
            return try encoded(path: url, params: ["request_token" : session])
        case .getGenreWithPage(genreId:  let genreId, page: let page):
            let url = "discover/movie?"
            return try encoded(path: url, params: ["with_genres" : genreId , "page" : page])
        case .login(username: let username, password: let password,request_token: let request_token):
            let url = "authentication/token/validate_with_login?"
            return try encoded(path: url, params: ["username": username, "password" : password, "request_token" : request_token])
        case .getGenre:
            let url = "genre/movie/list?"
            let params :[String:Any] =  [:]
            return try encoded(path: url, params: params)
        case .getToken:
            let url = "authentication/token/new?"
            let params :[String:Any] =  [:]
            return try encoded(path: url, params: params)
        case .getMoviesByGenre(genreId: let genreId):
            let url = "discover/movie?"
            return try encoded(path: url, params: ["with_genres" : genreId])
        }
    }
   
    var method: HTTPMethod{
        switch self{
        case .getSimilars(movie_id: _):
            return .get
        case .setFavorite(movie_id: _):
            return .post
        case.getFavorites:
            return .get
        case.getMovies(page: _):
            return .get
        case .getByLetter(letters: _):
            return .get
        case .getSession(request_token: _):
            return .post
        case .getGenreWithPage(genreId:  _, page: _):
            return .get
        case .login(username: _, password: _, request_token: _):
            return .post
        case .getToken:
            return .get
        case .getGenre:
            return .get
        case .getMoviesByGenre(genreId: _):
           return .get
        }
    }
    var sessionPolicy: APIRouteSessionPolicy{
        switch self{
        case .getSimilars(movie_id: _):
            return .publicDomain
        case .setFavorite( movie_id: _):
            return .privateDomain
        case .getFavorites:
            return .privateDomain
        case .getMovies(page: _):
            return .publicDomain
        case .getByLetter(letters: _):
            return .publicDomain
        case .getSession(request_token: _):
            return .publicDomain
        case .getGenreWithPage(genreId:  _, page: _ ):
            return .publicDomain
        case .login(username: _, password: _, request_token: _):
        return .publicDomain
        case.getToken:
        return .publicDomain
        case .getGenre:
        return .publicDomain
        case .getMoviesByGenre(genreId: _):
            return .publicDomain
        }}
    
    
}

