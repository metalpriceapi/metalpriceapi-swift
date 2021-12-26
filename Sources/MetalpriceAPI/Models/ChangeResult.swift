import Foundation

public struct ChangeResult: Codable {
    public let success: Bool
    public let base: String
    public let startDate: String
    public let endDate: String
    public let rates: [String: [String: Double]]
    
    public init(success: Bool, base: String, startDate: String, endDate: String, rates: [String: [String: Double]]) {
        self.success = success
        self.base = base
        self.startDate = startDate
        self.endDate = endDate
        self.rates = rates
    }
    
    private enum CodingKeys: String, CodingKey {
        case success
        case base
        case startDate = "start_date"
        case endDate = "end_date"
        case rates
    }
}
