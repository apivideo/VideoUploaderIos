//
// AdvancedAuthenticationnAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

open class AdvancedAuthenticationnAPI {

    /**
     Refresh Bearer Token
     
     - parameter refreshTokenPayload: (body)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func refresh(refreshTokenPayload: RefreshTokenPayload, apiResponseQueue: DispatchQueue = ApiVideoUploader.apiResponseQueue, completion: @escaping ((_ data: AccessToken?, _ error: Error?) -> Void)) -> RequestTask {
            return refreshWithRequestBuilder(refreshTokenPayload: refreshTokenPayload).execute(apiResponseQueue) { result in
                switch result {
                case let .success(response):
                    completion(response.body, nil)
                case let .failure(error):
                    completion(nil, error)
                }
            }
    }


    /**
     Refresh Bearer Token
     - POST /auth/refresh
     - Accepts the old bearer token and returns a new bearer token that can be used to authenticate other endpoint.  You can find the tutorial on using the disposable bearer token [here](https://docs.api.video/reference/disposable-bearer-token-authentication).
     - parameter refreshTokenPayload: (body)  
     - returns: RequestBuilder<AccessToken> 
     */
    open class func refreshWithRequestBuilder(refreshTokenPayload: RefreshTokenPayload) -> RequestBuilder<AccessToken> {
        let localVariablePath = "/auth/refresh"
        let localVariableURLString = ApiVideoUploader.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: refreshTokenPayload)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<AccessToken>.Type = ApiVideoUploader.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }

}
