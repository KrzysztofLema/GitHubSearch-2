import Foundation

struct ItemDTO: Codable {
    let id: Int?
    let nodeId: String?
    let name: String?
    let fullName: String?
    let owner: OwnerDTO?
    let isPrivate: Bool?
    let htmlUrl: String?
    let description: String?
    let fork: Bool?
    let url: String?
    let createdAt: Date?
    let updatedAt: Date?
    let pushedAt: Date?
    let homepage: String?
    let size: Int?
    let stargazersCount: Int?
    let watchersCount: Int?
    let language: String?
    let forksCount: Int?
    let openIssuesCount: Int?
    let masterBranch: String?
    let defaultBranch: String?
    let score: Int?
    let forksUrl: String?
    let keysUrl: String?
    let collaboratorsUrl: String?
    let teamsUrl: String?
    let hooksUrl: String?
    let issueEventsUrl: String?
    let eventsUrl: String?
    let assigneesUrl: String?
    let branchesUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case nodeId = "node_id"
        case name
        case fullName = "full_name"
        case owner
        case isPrivate = "private"
        case htmlUrl = "html_url"
        case description
        case fork
        case url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case homepage
        case size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case masterBranch = "master_branch"
        case defaultBranch = "default_branch"
        case score
        case forksUrl = "forks_url"
        case keysUrl = "keys_url"
        case collaboratorsUrl = "collaborators_url"
        case teamsUrl = "teams_url"
        case hooksUrl = "hooks_url"
        case issueEventsUrl = "issue_events_url"
        case eventsUrl = "events_url"
        case assigneesUrl = "assignees_url"
        case branchesUrl = "branches_url"
    }

    init(id: Int?, 
         nodeId: String?, 
         name: String?,
         fullName: String?,
         owner: OwnerDTO?,
         isPrivate: Bool?,
         htmlUrl: String?,
         description: String?,
         fork: Bool?,
         url: String?,
         createdAt: Date?,
         updatedAt: Date?,
         pushedAt: Date?,
         homepage: String?,
         size: Int?,
         stargazersCount: Int,
         watchersCount: Int,
         language: String?,
         forksCount: Int?,
         openIssuesCount: Int?,
         masterBranch: String?,
         defaultBranch: String?,
         score: Int?,
         forksUrl: String,
         keysUrl: String,
         collaboratorsUrl: String,
         teamsUrl: String,
         hooksUrl: String,
         issueEventsUrl: String,
         eventsUrl: String,
         assigneesUrl: String,
         branchesUrl: String
    ) {
        self.id = id
        self.nodeId = nodeId
        self.name = name
        self.fullName = fullName
        self.owner = owner
        self.isPrivate = isPrivate
        self.htmlUrl = htmlUrl
        self.description = description
        self.fork = fork
        self.url = url
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.pushedAt = pushedAt
        self.homepage = homepage
        self.size = size
        self.stargazersCount = stargazersCount
        self.watchersCount = watchersCount
        self.language = language
        self.forksCount = forksCount
        self.openIssuesCount = openIssuesCount
        self.masterBranch = masterBranch
        self.defaultBranch = defaultBranch
        self.score = score
        self.forksUrl = forksUrl
        self.keysUrl = keysUrl
        self.collaboratorsUrl = collaboratorsUrl
        self.teamsUrl = teamsUrl
        self.hooksUrl = hooksUrl
        self.issueEventsUrl = issueEventsUrl
        self.eventsUrl = eventsUrl
        self.assigneesUrl = assigneesUrl
        self.branchesUrl = branchesUrl
    }
}
