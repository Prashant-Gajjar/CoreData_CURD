//
//  DataTblViewCell.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 10/12/22.
//

import UIKit

class DataTblViewCell: UITableViewCell {

    @IBOutlet weak var imgvProfile: UIImageView!
    @IBOutlet private weak var lblUsername  : UILabel!
    @IBOutlet private weak var lblEmail     : UILabel!
    @IBOutlet private weak var lblPassword  : UILabel!
    @IBOutlet private weak var lblSubId     : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpCellWith(obj: UserModel) {
        lblUsername.text    = obj.username
        lblEmail.text       = obj.email
        lblPassword.text    = obj.password
        lblSubId.text       = "Sub Id: \(obj.subscription?.subscriptionId ?? "NA")"
        imgvProfile.image   = UIImage(data: obj.profileImage)
    }
    
    func setUpCellWith(obj: SubscriptionModel) {
        lblUsername.text    = obj.username
        lblEmail.text       = nil
        lblPassword.text    = nil
        lblSubId.text       = "Sub Id: \(obj.subscriptionId ?? "NA")"
        imgvProfile.image   = nil
    }
    
}
