//  ApiVideoAuthenticator.swift
//

import Foundation
import Alamofire

class ApiVideoAuthenticator: Authenticator {
    private let apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func apply(_ credential: ApiVideoCredential, to urlRequest: inout URLRequest) {
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
    }

    func refresh(_ credential: ApiVideoCredential,
                 for session: Session,
                 completion: @escaping (Result<ApiVideoCredential, Error>) -> Void) {
        AdvancedAuthenticationAPI.authenticate(authenticatePayload: AuthenticatePayload(apiKey: apiKey)) { accessToken, error in
            if let error = error {
                completion(.failure(error))
            }
            if let accessToken = accessToken {
                ApiVideoUploader.credential = ApiVideoCredential(accessToken: accessToken)
                completion(.success(ApiVideoUploader.credential))
            }
        }
    }

    func didRequest(_ urlRequest: URLRequest,
                    with response: HTTPURLResponse,
                    failDueToAuthenticationError error: Error) -> Bool {
        // If authentication server CANNOT invalidate credentials, return `false`
        if response.statusCode != 401 {
            return false
        }

        // If authentication server CAN invalidate credentials, then inspect the response matching against what the
        // authentication server returns as an authentication failure.
        // We request a new access token if we received a 401 anyway.
        return true
    }

    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: ApiVideoCredential) -> Bool {
        // If authentication server CAN invalidate credentials, then compare the "Authorization" header value in the
        // `URLRequest` against the Bearer token generated with the access token of the `Credential`.
        let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
        return urlRequest.headers["Authorization"] == bearerToken
    }
}
