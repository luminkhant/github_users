//
//  UserDM.swift
//  GithubUsers
//
//  Created by Min Khant Lu on 1/27/20.
//  Copyright © 2020 minkhant. All rights reserved.
//

import Foundation
import Alamofire
class UserDM{
    func fetchUserPerPage(page : Int,per_page : Int,
                          completionHandler : @escaping (Bool,[UserViewModel]) -> ()) {
        
        Alamofire.request(getEndPoint(),
                          method: .get,
                          parameters:  ["page": page,"per_page" : per_page])
        .validate()
        .responseJSON{response in
            let result = self.handleUserFetchRequest(response: response)
            completionHandler(result.0,result.1)
        }
    }
    
    func handleUserFetchRequest(response : DataResponse<Any>) -> (Bool,[UserViewModel]){
        var userViewModels = [UserViewModel]()
        var isSuccess = false
        switch response.result {
        case .success(let value) :
            if let userObjArray = value as? NSArray{
                for index in 0..<userObjArray.count{
                    if let userObj = userObjArray[index] as? NSDictionary{
                        let userVM = UserViewModel(user: User(json: userObj))
                        userViewModels.append(userVM)
                    }
                }
            }
            isSuccess = true
            break
        case .failure(_ ) :
            break
        }
        return (isSuccess,userViewModels)
    }
}
