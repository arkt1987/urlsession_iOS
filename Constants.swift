//
//  Constants.swift
//  testApp
//
//  Created by SAIL on 26/05/23.
//

import Foundation
import UIKit

public class Constant {
  
    enum serverType: String {
        case live = ""
        case demo = "http://192.168.96.250/MysqlLogin/api/user/login.php"
    }
    
    static let baseUrl: serverType = .demo
}
