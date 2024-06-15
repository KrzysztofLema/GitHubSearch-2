import Foundation

public struct SearchResultResponseDTO: Codable {
    public let totalCount: Int?
    public let incompleteResults: Bool?
    public let items: [ItemDTO]?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
