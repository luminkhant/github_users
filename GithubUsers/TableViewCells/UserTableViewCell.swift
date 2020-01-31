//
//  UserTableViewCell.swift
//  GithubUsers
//
//  Created by Min Khant Lu on 1/27/20.
//  Copyright © 2020 minkhant. All rights reserved.
//

import UIKit
import Kingfisher
import Toast_Swift
class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblLoginName: UILabel!
    @IBOutlet weak var lblAccountType: UILabel!
    
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var lblSiteAdminStatus: UILabel!
    @IBOutlet weak var btnGetUrl: UIButton!
    
    var viewModel : UserViewModel!
    var delegate : UserTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(user : UserViewModel){
        self.viewModel = user
        self.viewModel.configureView(self)
    }
    
    @IBAction func clickedFav(_ sender: Any) {
        delegate?.didChangeFav(self)
    }
    
    @IBAction func btnGetUrlAction(_ sender: Any) {
        delegate?.didCopyURL(self)
    }
    
}

protocol UserTableViewCellDelegate {
    func didChangeFav(_ sender : UserTableViewCell)
    func didCopyURL(_ sender : UserTableViewCell)
}

extension UserViewModel {
    func configureView(_ view : UserTableViewCell){
        view.imgAvatar.kf.setImage(with: URL(string: getAvatarImage()))
        view.lblLoginName.text = getLogin()
        view.lblAccountType.text = getAccountType()
        view.lblSiteAdminStatus.isHidden = !isSiteAdmin()
        view.btnFav.setImage(getFavImage(), for: .normal)
    }
}
