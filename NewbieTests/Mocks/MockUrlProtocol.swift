//
//  MockUrlProtocol.swift
//  NewbieTests
//
//  Created by Raj.P, Varun (Cognizant) on 13/08/24.
//

import Foundation

class MockUrlProtocol: URLProtocol {
    
    static var stubResponseData: Data?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func stopLoading() {
        
    }
    
    override func startLoading() {
        if let error = MockUrlProtocol.error {
            let err = NSError(domain: "StubNSError", code: -99, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
            self.client?.urlProtocol(self, didFailWithError: err)
        } else {
            self.client?.urlProtocol(self, didLoad: MockUrlProtocol.stubResponseData ?? Data())
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
}
