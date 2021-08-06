//
//  SingletonModel.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 30/7/21.
//

import Foundation
struct Settings {
    static var shared = Settings()
    var sessionId: String?
    var categories: [Int] = [28,12,16,10751,36,10402,10749,35]
    
    func getSession() -> String?{
        return self.sessionId
    }
    
    private init() { }
}




