//
//  UserViewModel.swift
//  GithubUsers
//
//  Created by Min Khant Lu on 1/27/20.
//  Copyright © 2020 minkhant. All rights reserved.
//

import Foundation
import UIKit
class UserViewModel {
    let user : User
    let IMG_FAV = UIImage(named: "ic_fav")
    let IMG_NOT_FAV = UIImage(named: "ic_not_fav")
    
    init(user : User) {
        self.user = user
    }
    
    func setFav(){
        user.favorite_status = !user.favorite_status
    }
    
    func getLogin() -> String{
        if let login = user.login{
            return login
        }
        return "-"
    }
    
    func getAvatarImage() -> String{
        if let avatar_url = user.avatar{
            return avatar_url
        }
        return "-"
    }
    
    func getAccountType() -> String{
        if let account_type = user.account_type{
            return account_type
        }
        return "-"
    }
    
    func getFavImage() -> UIImage{
        return user.favorite_status ? IMG_FAV! : IMG_NOT_FAV!
    }
    
    func isSiteAdmin() -> Bool{
        if let status = user.site_admin_status{
            return status
        }
        return false
    }
    
    func getGithubUrl() -> String{
        if let url = user.github_url{
            return url
        }
        return ""
    }
    
    func isFavourite() -> Bool{
        return user.favorite_status
    }
}
