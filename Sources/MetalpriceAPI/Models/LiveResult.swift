import Foundation

public struct LiveResult: Codable {
    public let success: Bool
    public let base: String
    public let timestamp: TimeInterval
    public let rates: [String: Double]
    
    public init(success: Bool, base: String, timestamp: TimeInterval, rates: [String: Double]) {
        self.success = success
        self.base = base
        self.timestamp = timestamp
        self.rates = rates
    }
}
