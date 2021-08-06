//
//  SessionModel.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 1/8/21.
//

import Foundation
import ObjectMapper
class Session: Mappable {
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.success <- map["success"]
        self.session_id <- map["session_id"]
    }
    
    var success: Int!
    var session_id : String!
    
    init(success: Int,session_id: String ) {
        self.session_id = session_id
        self.success = success
    }
}
