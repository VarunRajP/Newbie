//
//  OrderViewModel.swift
//  Newbie
//
//  Created by Raj.P, Varun (Cognizant) on 13/08/24.
//

import Foundation

struct OrderViewModel {
    
    let order: OrderListModel

}

class OrderListViewModel: OrderListProtocol {
    
    var ordersList = [OrderViewModel]()
    let getOrdersViewModel: GetOrderListProtocol?
    
    init(ordersList: [OrderViewModel] = [OrderViewModel](), getOrdersViewModel: GetOrderListProtocol?) {
        self.ordersList = ordersList
        self.getOrdersViewModel = getOrdersViewModel
    }
    
    var noOfRows: Int {
        ordersList.count
    }
    
    func orderAtIndex(index: Int) -> OrderViewModel {
        return ordersList[index]
    }
    
}
