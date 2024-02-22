import Foundation

public struct CaratResult: Codable {
    public let success: Bool
    public let base: String
    public let timestamp: TimeInterval
    public let data: [String: Double]

    public init(success: Bool, base: String, timestamp: TimeInterval, data: [String: Double]) {
        self.success = success
        self.base = base
        self.timestamp = timestamp
        self.data = data
    }
}
