import Foundation

struct LicenseDTO: Codable {
    let key: String
    let name: String?
    let url: String?
    let spdxId: String
    let nodeId: String?
    let htmlUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case key
        case name
        case url
        case spdxId = "spdx_id"
        case nodeId = "node_id"
        case htmlUrl = "html_url"
    }
}
