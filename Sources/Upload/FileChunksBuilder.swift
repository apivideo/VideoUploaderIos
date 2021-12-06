//  FileChunksBuilder.swift
//

import Foundation

class FileChunksBuilder {
    private let fileURL: URL
    let fileSize: Int64

    public init(fileURL: URL) throws {
        self.fileURL = fileURL
        self.fileSize = try Int64(fileURL.resourceValues(forKeys: [URLResourceKey.fileSizeKey]).fileSize!)
    }

    public func build() -> [ChunkInputStream] {
        var chunks: [ChunkInputStream] = []
        for offset in stride(from: UInt64(0), through: UInt64(fileSize), by: ApiVideoUploader.getChunkSize()) {
            chunks.append(ChunkInputStream(fileURL: fileURL, offset: offset, maxSize: min(ApiVideoUploader.getChunkSize(), Int(UInt64(fileSize) - offset))))
        }

        return chunks
    }
}
