// APIs.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
enum ApiVideoUploaderError: Error {
    case invalidApplicationName
}

public class ApiVideoUploader {
    private static let DEFAULT_USER_AGENT = "api.video uploader (iOS; v:0.1.3; )";

    public static var apiKey: String? = nil
    public static var basePath = "https://ws.api.video"
    internal  static var customHeaders:[String: String] = ["User-Agent": ApiVideoUploader.DEFAULT_USER_AGENT]
    private static var chunkSize: Int = 50 * 1024 * 1024
    internal static var requestBuilderFactory: RequestBuilderFactory = AlamofireRequestBuilderFactory()
    internal static var credential = ApiVideoCredential()
    public static var apiResponseQueue: DispatchQueue = .main

    public static func setChunkSize(chunkSize: Int) throws {
        if (chunkSize > 128 * 1024 * 1024) {
            throw ParameterError.outOfRange
        } else if (chunkSize < 5 * 1024 * 1024) {
            throw ParameterError.outOfRange
        }
        
        ApiVideoUploader.chunkSize = chunkSize
    }

    public static func getChunkSize() -> Int {
        return ApiVideoUploader.chunkSize
    }

    public static func setApplicationName(applicationName: String) throws {
        let pattern = #"^[\w\-.\/]{1,50}$"#
        let regex = try! NSRegularExpression(pattern: pattern, options: .anchorsMatchLines)
        let stringRange = NSRange(location: 0, length: applicationName.utf16.count)
        let matches = regex.matches(in: applicationName, range: stringRange)
        if(matches.isEmpty) {
            throw ApiVideoUploaderError.invalidApplicationName
        }
        ApiVideoUploader.customHeaders["User-Agent"] = ApiVideoUploader.DEFAULT_USER_AGENT + " " + applicationName
    }
}

open class RequestBuilder<T> {
    var headers: [String: String]
    public let parameters: [String: Any]?
    public let method: String
    public let URLString: String

    /// Optional block to obtain a reference to the request's progress instance when available.
    public let onProgressReady: ((Progress) -> Void)?

    required public init(method: String, URLString: String, parameters: [String: Any]?, headers: [String: String] = [:], onProgressReady: ((Progress) -> Void)? = nil) {
        self.method = method
        self.URLString = URLString
        self.parameters = parameters
        self.headers = headers
        self.onProgressReady = onProgressReady

        addHeaders(ApiVideoUploader.customHeaders)
    }

    open func addHeaders(_ aHeaders: [String: String]) {
        for (header, value) in aHeaders {
            headers[header] = value
        }
    }

    @discardableResult
    open func execute(_ apiResponseQueue: DispatchQueue = ApiVideoUploader.apiResponseQueue, _ completion: @escaping (_ result: Swift.Result<Response<T>, ErrorResponse>) -> Void) -> URLSessionTask? {
        return nil
    }

    public func addHeader(name: String, value: String) -> Self {
        if !value.isEmpty {
            headers[name] = value
        }
        return self
    }
}

public protocol RequestBuilderFactory {
    func getNonDecodableBuilder<T>() -> RequestBuilder<T>.Type
    func getBuilder<T: Decodable>() -> RequestBuilder<T>.Type
}
