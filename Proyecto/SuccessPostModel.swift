//
//  SuccessPostModel.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 3/8/21.
//

import Foundation
import ObjectMapper
class SuccessPostModel:Mappable{
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.success <- map["success"]
        self.status_code <- map["status_code"]
        self.status_message <- map["status_message"]

    }
    
    var success : String!
    var status_code :Int!
    var status_message : String!
    
    init( success : String,status_code :Int,status_message : String) {
        self.success = success
        self.status_code = status_code
        self.status_message = status_message
    }

}
