//
//  OrdersListTableViewCell.swift
//  Newbie
//
//  Created by Raj.P, Varun (Cognizant) on 12/08/24.
//

import UIKit

class OrdersListTableViewCell: UITableViewCell {

    @IBOutlet weak var title_Lbl: UILabel!
    @IBOutlet weak var subTitle_Lbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data: OrderViewModel) {
        title_Lbl.text = data.order.email
        subTitle_Lbl.text = data.order.type
    }
}
