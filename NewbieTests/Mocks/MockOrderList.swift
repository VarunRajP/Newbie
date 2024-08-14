//
//  MockOrderList.swift
//  NewbieTests
//
//  Created by Raj.P, Varun (Cognizant) on 13/08/24.
//

import Foundation
@testable import Newbie

class MockOrderList: OrderListProtocol {
    
    func orderAtIndex(index: Int) -> Newbie.OrderViewModel {
        return OrderViewModel(order: OrderListModel(createdAt: "13-1-11", name: "Varun", email: "varun@gmail.com", type: "type1", size: "size1", id: "1"))
    }
    
}
