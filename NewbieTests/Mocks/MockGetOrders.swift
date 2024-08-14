//
//  MockGetOrders.swift
//  NewbieTests
//
//  Created by Raj.P, Varun (Cognizant) on 14/08/24.
//

import Foundation
@testable import Newbie

class MockGetOrderList: GetOrderListProtocol {
    
    var isGetOrdersApiCalled = false
    
    func fetchOrders(completion: @escaping (Result<[Newbie.OrderViewModel], Newbie.NetworkError>) -> ()) {
        isGetOrdersApiCalled = true
        
        let response = OrderViewModel(order: OrderListModel(createdAt: "13-1-11", name: "Varun", email: "varun@gmail.com", type: "type1", size: "size1", id: "1"))
        completion(.success([response]))
    }
    
}
