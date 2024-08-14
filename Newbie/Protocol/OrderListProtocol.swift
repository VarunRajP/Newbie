//
//  OrderListProtocol.swift
//  Newbie
//
//  Created by Raj.P, Varun (Cognizant) on 13/08/24.
//

import Foundation

protocol OrderListProtocol {
    func orderAtIndex(index: Int) -> OrderViewModel
}

protocol GetOrderListProtocol {
    func fetchOrders(completion: @escaping (Result<[OrderViewModel], NetworkError>) -> ())
}
