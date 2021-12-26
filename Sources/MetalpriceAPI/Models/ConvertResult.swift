import Foundation

public struct ConvertQuery: Codable {
    public let from: String
    public let to: String
    public let amount: Double
    
    public init(from: String, to: String, amount: Double) {
        self.from = from
        self.to = to
        self.amount = amount
    }
}

public struct ConvertInfo: Codable {
    public let quote: Double
    public let timestamp: TimeInterval
    
    public init(quote: Double, timestamp: TimeInterval) {
        self.quote = quote
        self.timestamp = timestamp
    }
}

public struct ConvertResult: Codable {
    public let success: Bool
    public let query: ConvertQuery
    public let info: ConvertInfo
    public let result: Double
    
    public init(success: Bool, query: ConvertQuery, info: ConvertInfo, result: Double) {
        self.success = success
        self.query = query
        self.info = info
        self.result = result
    }
}
