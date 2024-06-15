import Foundation

public struct LicenseDTO: Codable {
    public let key: String
    public let name: String?
    public let url: String?
    public let spdxId: String
    public let nodeId: String?
    public let htmlUrl: String?

    enum CodingKeys: String, CodingKey {
        case key
        case name
        case url
        case spdxId = "spdx_id"
        case nodeId = "node_id"
        case htmlUrl = "html_url"
    }
}
