//
//  GetOrdersViewModel.swift
//  Newbie
//
//  Created by Raj.P, Varun (Cognizant) on 14/08/24.
//

import Foundation

class GetOrdersViewModel: GetOrderListProtocol {
    
    private var urlSession: URLSession
    private var url: URL
    
    init(url: URL, urlSession: URLSession = .shared) {
        self.url = url
        self.urlSession = urlSession
    }
    
    func fetchOrders(completion: @escaping (Result<[OrderViewModel], NetworkError>) -> ()) {
        WebService().load(url: url, urlSession: urlSession) { (result: Result<[OrderListModel], NetworkError>) in
            switch result {
            case .success(let data):
                let vm = data.map(OrderViewModel.init)
                completion(.success(vm))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
