//
//  APIAdapter.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 4/6/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import Foundation
import Alamofire

typealias SuccesBlock  = (_ result: Data) -> Void
typealias FailureBlock = (_ errorMessage: String) -> Void

class APIAdapter {
    
    static let baseURL = "https://content.guardianapis.com/search"
    static let apiKey  = "21b5f554-603d-490a-96bd-00531b3158f1"
    
    public static func request( method: HTTPMethod,
                                parameters: [String: Any],
                                successBlock: @escaping SuccesBlock,
                                failureBlock: FailureBlock? = nil)
    {
        let manager = Alamofire.SessionManager.default
        var params = parameters
        params["api-key"] = apiKey
        
        manager.session.configuration.timeoutIntervalForRequest = 20
        manager.request(baseURL,
                        method: method,
                        parameters: params)
					.responseData(completionHandler: { (response) in
						switch response.result {
						case .success(let data):
							successBlock(data)
						case .failure(let error):
							if let blk = failureBlock {
								blk(error.localizedDescription)
							}
							print("\nError:   code === \(error._code) " + "\(error.localizedDescription)\n")
						}
					})
    }
}
