//
//  LoginResponseModel.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 30/7/21.
//

import Foundation
import ObjectMapper
class LoginResponse:Mappable {
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.success <- map["success"]
        self.expires_at <- map["expires_at"]
        self.request_token <- map["request_token"]
    }
    
    var success : Int!
    var expires_at : String!
    var request_token : String!
    
    init(success: Int,expires_at: String,request_token: String ){
        self.success = success
        self.expires_at = expires_at
        self.request_token = request_token
    }
}
