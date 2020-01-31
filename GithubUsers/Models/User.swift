//
//  User.swift
//  GithubUsers
//
//  Created by Min Khant Lu on 1/27/20.
//  Copyright © 2020 minkhant. All rights reserved.
//

import Foundation
class User : NSObject{
    var login : String?
    var avatar : String?
    var github_url : String?
    var account_type : String?
    var site_admin_status : Bool?
    var favorite_status = false
    
    init(json : NSDictionary) {
        if let login = json["login"] as? String{
            self.login = login
        }
        if let avatar = json["avatar_url"] as? String{
            self.avatar = avatar
        }
        if let github_url = json["html_url"] as? String{
            self.github_url = github_url
        }
        if let type = json["type"] as? String{
            self.account_type = type
        }
        if let site_admin_status = json["site_admin"] as? Bool{
            self.site_admin_status = site_admin_status
        }
    }
    
}
