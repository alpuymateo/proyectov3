//
//  GendreModel.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 25/7/21.
//
import ObjectMapper
import Foundation
class Genre: Mappable {
    required init?(map: Map) {
       
    }
    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
    }
    
    var id: Int!
    var name : String!
    
    init(id: Int,name : String ){
        self.id = id
        self.name = name
    }
}
