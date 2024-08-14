//
//  NewbieTests.swift
//  NewbieTests
//
//  Created by Raj.P, Varun (Cognizant) on 12/08/24.
//

import XCTest
@testable import Newbie

final class OrderListTests: XCTestCase {

    private var orderListVM: OrderListViewModel!
    
    override func setUpWithError() throws {
        let order = OrderListModel(createdAt: "13-1-11", name: "Varun", email: "varun@gmail.com", type: "type1", size: "size1", id: "1")
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockUrlProtocol.self]
        let urlSession = URLSession(configuration: config)

        orderListVM = OrderListViewModel(ordersList: [OrderViewModel(order: order)], getOrdersViewModel: GetOrdersViewModel(url: URL(string: Constants.Urls.orders)!, urlSession: urlSession))
    }

    override func tearDownWithError() throws {
        orderListVM = nil
        
        MockUrlProtocol.stubResponseData = nil
        MockUrlProtocol.error = nil
    }

    func testOrderListViewModel_WhenGiveSuccessfullResponse_ShouldReturnCount() {
        let jsonString = "[\n  {\n    \"createdAt\": \"2024-08-12T06:03:23.033Z\",\n    \"name\": \"name 1\",\n    \"email\": \"email 1\",\n    \"type\": \"type 1\",\n    \"size\": \"size 1\",\n    \"id\": \"1\"\n  }\n]"
        MockUrlProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Orders list web service expectation")
        
        orderListVM.getOrdersViewModel?.fetchOrders(completion: { result in
            switch result {
            case .success(let list):
                XCTAssertEqual(list.count, 1, "Orders list web service should have returned count by one")
            case .failure(_): break
            }
            expectation.fulfill()
        })
        
        self.wait(for: [expectation], timeout: 5)
    }

    func testOrderListViewModel_WhenGivenFailureResponse_ShouldReturnError() {
        let jsonString = "{\"error\":\"Internal Server Error\"}"
        MockUrlProtocol.stubResponseData = jsonString.data(using: .utf8)

        let expectation = self.expectation(description: "Order list web service failure expectation")
        
        orderListVM.getOrdersViewModel?.fetchOrders(completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(let failure):
                XCTAssertEqual(failure, NetworkError.invalidReponseModel)
            }
            
            expectation.fulfill()
        })
        
        self.wait(for: [expectation], timeout: 5)
    }
}
