import Foundation

struct ItemDTO: Codable {
    let id: Int?
    let nodeID, name, fullName: String?
    let owner: OwnerDTO?
    let itemPrivate: Bool?
    let htmlURL: String?
    let description: String?
    let fork: Bool?
    let url: String?
    let createdAt, updatedAt, pushedAt: Date?
    let homepage: String?
    let size, stargazersCount, watchersCount: Int?
    let language: String?
    let forksCount, openIssuesCount: Int?
    let masterBranch, defaultBranch: String?
    let score: Int?
    let archiveURL, assigneesURL, blobsURL, branchesURL: String?
    let collaboratorsURL, commentsURL, commitsURL, compareURL: String?
    let contentsURL: String?
    let contributorsURL, deploymentsURL, downloadsURL, eventsURL: String?
    let forksURL: String?
    let gitCommitsURL, gitRefsURL, gitTagsURL, gitURL: String?
    let issueCommentURL, issueEventsURL, issuesURL, keysURL: String?
    let labelsURL: String?
    let languagesURL, mergesURL: String?
    let milestonesURL, notificationsURL, pullsURL, releasesURL: String?
    let sshURL: String?
    let stargazersURL: String?
    let statusesURL: String?
    let subscribersURL, subscriptionURL, tagsURL, teamsURL: String?
    let treesURL: String?
    let cloneURL: String?
    let mirrorURL: String?
    let hooksURL, svnURL: String?
    let forks, openIssues, watchers: Int?
    let hasIssues, hasProjects, hasPages, hasWiki: Bool?
    let hasDownloads, archived, disabled: Bool?
    let visibility: String?
    let license: LicenseDTO?
    
    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case owner
        case itemPrivate = "private"
        case htmlURL = "html_url"
        case description, fork, url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case homepage, size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case masterBranch = "master_branch"
        case defaultBranch = "default_branch"
        case score
        case archiveURL = "archive_url"
        case assigneesURL = "assignees_url"
        case blobsURL = "blobs_url"
        case branchesURL = "branches_url"
        case collaboratorsURL = "collaborators_url"
        case commentsURL = "comments_url"
        case commitsURL = "commits_url"
        case compareURL = "compare_url"
        case contentsURL = "contents_url"
        case contributorsURL = "contributors_url"
        case deploymentsURL = "deployments_url"
        case downloadsURL = "downloads_url"
        case eventsURL = "events_url"
        case forksURL = "forks_url"
        case gitCommitsURL = "git_commits_url"
        case gitRefsURL = "git_refs_url"
        case gitTagsURL = "git_tags_url"
        case gitURL = "git_url"
        case issueCommentURL = "issue_comment_url"
        case issueEventsURL = "issue_events_url"
        case issuesURL = "issues_url"
        case keysURL = "keys_url"
        case labelsURL = "labels_url"
        case languagesURL = "languages_url"
        case mergesURL = "merges_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case pullsURL = "pulls_url"
        case releasesURL = "releases_url"
        case sshURL = "ssh_url"
        case stargazersURL = "stargazers_url"
        case statusesURL = "statuses_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case tagsURL = "tags_url"
        case teamsURL = "teams_url"
        case treesURL = "trees_url"
        case cloneURL = "clone_url"
        case mirrorURL = "mirror_url"
        case hooksURL = "hooks_url"
        case svnURL = "svn_url"
        case forks
        case openIssues = "open_issues"
        case watchers
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasPages = "has_pages"
        case hasWiki = "has_wiki"
        case hasDownloads = "has_downloads"
        case archived, disabled, visibility, license
    }
    
    init(
        id: Int?,
        nodeID: String?,
        name: String?,
        fullName: String?,
        owner: OwnerDTO?,
        itemPrivate: Bool?,
        htmlURL: String?,
        description: String?,
        fork: Bool?,
        url: String?,
        createdAt: Date?,
        updatedAt: Date?,
        pushedAt: Date?,
        homepage: String?,
        size: Int?,
        stargazersCount: Int?,
        watchersCount: Int?,
        language: String?,
        forksCount: Int?,
        openIssuesCount: Int?,
        masterBranch: String?,
        defaultBranch: String?,
        score: Int?,
        archiveURL: String?,
        assigneesURL: String?,
        blobsURL: String?,
        branchesURL: String?,
        collaboratorsURL: String?,
        commentsURL: String?,
        commitsURL: String?,
        compareURL: String?,
        contentsURL: String?,
        contributorsURL: String?,
        deploymentsURL: String?,
        downloadsURL: String?, 
        eventsURL: String?,
        forksURL: String?,
        gitCommitsURL: String?,
        gitRefsURL: String?,
        gitTagsURL: String?,
        gitURL: String?,
        issueCommentURL: String?,
        issueEventsURL: String?,
        issuesURL: String?,
        keysURL: String?,
        labelsURL: String?,
        languagesURL: String?,
        mergesURL: String?,
        milestonesURL: String?,
        notificationsURL: String?,
        pullsURL: String?, 
        releasesURL: String?,
        sshURL: String?,
        stargazersURL: String?,
        statusesURL: String?,
        subscribersURL: String?,
        subscriptionURL: String?,
        tagsURL: String?,
        teamsURL: String?,
        treesURL: String?,
        cloneURL: String?,
        mirrorURL: String?,
        hooksURL: String?, 
        svnURL: String?,
        forks: Int?,
        openIssues: Int?,
        watchers: Int?,
        hasIssues:Bool?,
        hasProjects: Bool?,
        hasPages: Bool?,
        hasWiki: Bool?,
        hasDownloads: Bool?,
        archived: Bool?,
        disabled: Bool?,
        visibility: String?,
        license: LicenseDTO?
    ) {
        self.id = id
        self.nodeID = nodeID
        self.name = name
        self.fullName = fullName
        self.owner = owner
        self.itemPrivate = itemPrivate
        self.htmlURL = htmlURL
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
        self.archiveURL = archiveURL
        self.assigneesURL = assigneesURL
        self.blobsURL = blobsURL
        self.branchesURL = branchesURL
        self.collaboratorsURL = collaboratorsURL
        self.commentsURL = commentsURL
        self.commitsURL = commitsURL
        self.compareURL = compareURL
        self.contentsURL = contentsURL
        self.contributorsURL = contributorsURL
        self.deploymentsURL = deploymentsURL
        self.downloadsURL = downloadsURL
        self.eventsURL = eventsURL
        self.forksURL = forksURL
        self.gitCommitsURL = gitCommitsURL
        self.gitRefsURL = gitRefsURL
        self.gitTagsURL = gitTagsURL
        self.gitURL = gitURL
        self.issueCommentURL = issueCommentURL
        self.issueEventsURL = issueEventsURL
        self.issuesURL = issuesURL
        self.keysURL = keysURL
        self.labelsURL = labelsURL
        self.languagesURL = languagesURL
        self.mergesURL = mergesURL
        self.milestonesURL = milestonesURL
        self.notificationsURL = notificationsURL
        self.pullsURL = pullsURL
        self.releasesURL = releasesURL
        self.sshURL = sshURL
        self.stargazersURL = stargazersURL
        self.statusesURL = statusesURL
        self.subscribersURL = subscribersURL
        self.subscriptionURL = subscriptionURL
        self.tagsURL = tagsURL
        self.teamsURL = teamsURL
        self.treesURL = treesURL
        self.cloneURL = cloneURL
        self.mirrorURL = mirrorURL
        self.hooksURL = hooksURL
        self.svnURL = svnURL
        self.forks = forks
        self.openIssues = openIssues
        self.watchers = watchers
        self.hasIssues = hasIssues
        self.hasProjects = hasProjects
        self.hasPages = hasPages
        self.hasWiki = hasWiki
        self.hasDownloads = hasDownloads
        self.archived = archived
        self.disabled = disabled
        self.visibility = visibility
        self.license = license
    }
}
