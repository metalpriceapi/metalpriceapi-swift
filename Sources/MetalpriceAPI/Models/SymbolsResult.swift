import Foundation

public struct SymbolsResult: Codable {
    public let success: Bool
    public let symbols: [String: String]
    
    public init(success: Bool, symbols: [String: String]) {
        self.success = success
        self.symbols = symbols
    }
}
