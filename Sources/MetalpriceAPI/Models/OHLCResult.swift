import Foundation

public struct OHLCResult: Codable {
    public let success: Bool
    public let base: String
    public let timestamp: TimeInterval
    public let rate: OHLCRate

    public struct OHLCRate: Codable {
        public let close: Double
        public let high: Double
        public let low: Double
        public let open: Double

        public init(close: Double, high: Double, low: Double, open: Double) {
            self.close = close
            self.high = high
            self.low = low
            self.open = open
        }
    }

    public init(success: Bool, base: String, timestamp: TimeInterval, rate: OHLCRate) {
        self.success = success
        self.base = base
        self.timestamp = timestamp
        self.rate = rate
    }
}
