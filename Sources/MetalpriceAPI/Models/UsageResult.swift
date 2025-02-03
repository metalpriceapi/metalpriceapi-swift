import Foundation

public struct UsageResult: Codable {
    public let success: Bool
    public let result: UsageInfo

    public struct UsageInfo: Codable {
        public let plan: String
        public let used: Int
        public let total: Int
        public let remaining: Int

        public init(plan: String, used: Int, total: Int, remaining: Int) {
            self.plan = plan
            self.used = used
            self.total = total
            self.remaining = remaining
        }
    }

    public init(success: Bool, result: UsageInfo) {
        self.success = success
        self.result = result
    }
}
