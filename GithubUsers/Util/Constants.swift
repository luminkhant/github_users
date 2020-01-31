//
//  Constants.swift
//  GithubUsers
//
//  Created by Min Khant Lu on 1/27/20.
//  Copyright © 2020 minkhant. All rights reserved.
//

import Foundation
func getEndPoint() -> String{
    return "https://api.github.com/users"
}

enum STATUS {
    case failure
    case loading
    case blank
}

let COPY_TO_CLIPBOARD = "COPY TO CLIPBOARD"
