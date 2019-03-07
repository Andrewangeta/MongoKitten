import BSON

public struct CreateIndexesCommand: AdministrativeMongoDBCommand {
    typealias Reply = CreateIndexesReply
    
    internal var namespace: Namespace { return createIndexes }
    var isRetryableWrite: Bool { return false }
    
    internal let createIndexes: Namespace
    public var indexes: [Index]
    
    public init(_ indexes: [Index], for collection: Collection) {
        self.indexes = indexes
        self.createIndexes = collection.namespace
    }
}

struct CreateIndexesReply: ServerReplyDecodableResult {
    func makeResult(on collection: Collection) throws -> Void {}
    
    typealias Result = Void
    
    var isSuccessful: Bool { return ok == 1 }
    
    private let ok: Int
    private let errmsg: String?
    private let code: Int?
//    private let note: - only exists when an existing index was in place
}

public struct CreateIndexesError: ServerReplyDecodable {
    private let ok: Int
    
    public let createdCollectionAutomatically: Bool
    public let numIndexesBefore: Int
    public let numIndexesAfter: Int
    public let errmsg: String
    public let code: Int
    public let note: String?
}
