//
//  RequestInterceptor.swift
//  onTop
//
//  Created by Alexandru Vrincean on 02.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import Alamofire

final class RequestInterceptor {
    typealias RefreshTokensCompletion = (_ isSuccess: Bool, _ accessToken: String?, _ refreshToken: String?) -> Void
    private var accessToken: String?
    private var refreshToken: String?
    private let lock = NSLock()
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    private let refreshManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        return SessionManager(configuration: configuration)
    }()
}

extension RequestInterceptor: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        guard
            urlRequest.url?.absoluteString.hasPrefix(ApiConstants.coreURL) == true,
            let accessToken = accessToken
        else {
            /// If the request does not require authentication, we can directly return it as unmodified.
            return urlRequest
        }

        var urlRequest = urlRequest

        /// Set the Authorization header value using the access token.
        urlRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")

        return urlRequest
    }


}

extension RequestInterceptor: RequestRetrier {
    func should(
        _ manager: SessionManager,
        retry request: Request,
        with error: Error,
        completion: @escaping RequestRetryCompletion
    ) {
        lock.lock() ; defer { lock.unlock() }

        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(false, 0)
            return
        }

        requestsToRetry.append(completion)
        guard !isRefreshing else { return }

        refreshTokens { [weak self] isSuccess, accessToken, refreshToken in
            guard let self = self else { return }
            self.lock.lock() ; defer { self.lock.unlock() }

            if let accessToken = accessToken, let refreshToken = refreshToken {
                self.accessToken = accessToken
                self.refreshToken = refreshToken
                //API.storeRefreshToken(refreshToken)
            }

            self.requestsToRetry.forEach { $0(isSuccess, 0) }
            self.requestsToRetry.removeAll()

            if !isSuccess {
                //API.clearAccessToken()
            }
        }
    }

    /// Refreshes the tokens and returns the new ones upon completion
    func refreshTokens(completion: @escaping RefreshTokensCompletion) {
        guard !isRefreshing else { return }
        isRefreshing = true

        let params = [
            "authToken": accessToken ?? "",
            "refreshToken": refreshToken ?? ""
        ]

        refreshManager.request(
            "http://localhost:8605/api/tokens",
            method: .post,
            parameters: params,
            encoding: URLEncoding.default
        ).responseJSON { [weak self] response in
            guard let self = self else { return }
            if let json = response.result.value as? [String: Any],
                let accessToken = json["access_token"] as? String,
                let refreshToken = json["refresh_token"] as? String {
                completion(true, accessToken, refreshToken)
            } else {
                if ProcessInfo.processInfo.arguments.contains("UITest") {
                    completion(true, "", "")
                } else {
                    completion(false, nil, nil)
                }
            }
            self.isRefreshing = false
        }
    }
}

