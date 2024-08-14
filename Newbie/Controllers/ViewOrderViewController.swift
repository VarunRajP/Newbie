//
//  ViewOrderViewController.swift
//  Newbie
//
//  Created by Raj.P, Varun (Cognizant) on 13/08/24.
//

import UIKit

class ViewOrderViewController: UIViewController {

    @IBOutlet weak var title_Lbl: UILabel!
    @IBOutlet weak var subTitle_Lbl: UILabel!

    var orderVM: OrderViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
    }

    func setData() {
        self.title = "View Order"
        
        title_Lbl.text = orderVM?.order.email
        subTitle_Lbl.text = orderVM?.order.type
    }
}
