//
//  EmptyView.swift
//  GithubUsers
//
//  Created by Min Khant Lu on 1/28/20.
//  Copyright © 2020 minkhant. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var btnRetry: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    
    var status : STATUS = STATUS.loading
    var delegate : EmptyViewDelegate?
    
    
    func setData(status : STATUS){
        self.status = status
        configureView()
    }

    @IBAction func clickTryAgain(_ sender: Any) {
        delegate?.didReloadData(self)
    }
    
    func configureView() {
        btnRetry.layer.cornerRadius = 4
        
        switch self.status {
        case STATUS.failure:
            btnRetry.isHidden = false
            imgMain.image = UIImage(named: "ic_github_error")
            lblMessage.text = "Ooops! Something went wrong!"
        case STATUS.loading:
            imgMain.image = UIImage(named: "ic_github_loading")
            lblMessage.text = "Loading"
        case STATUS.blank :
            imgMain.image = UIImage(named: "ic_github_blank")
            lblMessage.text = "No Data. Please come back later"
        }
        
    }
}

protocol EmptyViewDelegate {
    func didReloadData(_ sender : EmptyView)
}
