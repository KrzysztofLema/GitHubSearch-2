import Foundation

struct SearchResultResponseDTO: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [ItemDTO]?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
