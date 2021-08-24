// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// Represents the individual results of a search.
public enum SearchType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// Returns results matching issues in repositories.
  case issue
  /// Returns results matching repositories.
  case repository
  /// Returns results matching users and organizations on GitHub.
  case user
  /// Returns matching discussions in repositories.
  case discussion
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "ISSUE": self = .issue
      case "REPOSITORY": self = .repository
      case "USER": self = .user
      case "DISCUSSION": self = .discussion
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .issue: return "ISSUE"
      case .repository: return "REPOSITORY"
      case .user: return "USER"
      case .discussion: return "DISCUSSION"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: SearchType, rhs: SearchType) -> Bool {
    switch (lhs, rhs) {
      case (.issue, .issue): return true
      case (.repository, .repository): return true
      case (.user, .user): return true
      case (.discussion, .discussion): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [SearchType] {
    return [
      .issue,
      .repository,
      .user,
      .discussion,
    ]
  }
}

public final class MyProfileQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query MyProfile($getFollowerCount: Int, $getFolloweeCount: Int) {
      viewer {
        __typename
        login
        name
        bio
        avatarUrl(size: 56)
        followers(first: $getFollowerCount) {
          __typename
          totalCount
          nodes {
            __typename
            avatarUrl(size: 44)
            login
          }
        }
        following(first: $getFolloweeCount) {
          __typename
          totalCount
          nodes {
            __typename
            avatarUrl(size: 44)
            login
          }
        }
      }
    }
    """

  public let operationName: String = "MyProfile"

  public var getFollowerCount: Int?
  public var getFolloweeCount: Int?

  public init(getFollowerCount: Int? = nil, getFolloweeCount: Int? = nil) {
    self.getFollowerCount = getFollowerCount
    self.getFolloweeCount = getFolloweeCount
  }

  public var variables: GraphQLMap? {
    return ["getFollowerCount": getFollowerCount, "getFolloweeCount": getFolloweeCount]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("viewer", type: .nonNull(.object(Viewer.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(viewer: Viewer) {
      self.init(unsafeResultMap: ["__typename": "Query", "viewer": viewer.resultMap])
    }

    /// The currently authenticated user.
    public var viewer: Viewer {
      get {
        return Viewer(unsafeResultMap: resultMap["viewer"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("login", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("bio", type: .scalar(String.self)),
          GraphQLField("avatarUrl", arguments: ["size": 56], type: .nonNull(.scalar(String.self))),
          GraphQLField("followers", arguments: ["first": GraphQLVariable("getFollowerCount")], type: .nonNull(.object(Follower.selections))),
          GraphQLField("following", arguments: ["first": GraphQLVariable("getFolloweeCount")], type: .nonNull(.object(Following.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(login: String, name: String? = nil, bio: String? = nil, avatarUrl: String, followers: Follower, following: Following) {
        self.init(unsafeResultMap: ["__typename": "User", "login": login, "name": name, "bio": bio, "avatarUrl": avatarUrl, "followers": followers.resultMap, "following": following.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The username used to login.
      public var login: String {
        get {
          return resultMap["login"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "login")
        }
      }

      /// The user's public profile name.
      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// The user's public profile bio.
      public var bio: String? {
        get {
          return resultMap["bio"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "bio")
        }
      }

      /// A URL pointing to the user's public avatar.
      public var avatarUrl: String {
        get {
          return resultMap["avatarUrl"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "avatarUrl")
        }
      }

      /// A list of users the given user is followed by.
      public var followers: Follower {
        get {
          return Follower(unsafeResultMap: resultMap["followers"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "followers")
        }
      }

      /// A list of users the given user is following.
      public var following: Following {
        get {
          return Following(unsafeResultMap: resultMap["following"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "following")
        }
      }

      public struct Follower: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["FollowerConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(totalCount: Int, nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "FollowerConnection", "totalCount": totalCount, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Identifies the total count of items in the connection.
        public var totalCount: Int {
          get {
            return resultMap["totalCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "totalCount")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["User"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("avatarUrl", arguments: ["size": 44], type: .nonNull(.scalar(String.self))),
              GraphQLField("login", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(avatarUrl: String, login: String) {
            self.init(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "login": login])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A URL pointing to the user's public avatar.
          public var avatarUrl: String {
            get {
              return resultMap["avatarUrl"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "avatarUrl")
            }
          }

          /// The username used to login.
          public var login: String {
            get {
              return resultMap["login"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "login")
            }
          }
        }
      }

      public struct Following: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["FollowingConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(totalCount: Int, nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "FollowingConnection", "totalCount": totalCount, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Identifies the total count of items in the connection.
        public var totalCount: Int {
          get {
            return resultMap["totalCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "totalCount")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["User"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("avatarUrl", arguments: ["size": 44], type: .nonNull(.scalar(String.self))),
              GraphQLField("login", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(avatarUrl: String, login: String) {
            self.init(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "login": login])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A URL pointing to the user's public avatar.
          public var avatarUrl: String {
            get {
              return resultMap["avatarUrl"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "avatarUrl")
            }
          }

          /// The username used to login.
          public var login: String {
            get {
              return resultMap["login"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "login")
            }
          }
        }
      }
    }
  }
}

public final class GetMyRepositoriesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetMyRepositories($first: Int!, $last: Int!) {
      viewer {
        __typename
        login
        repositories(first: $first, last: $last) {
          __typename
          edges {
            __typename
            node {
              __typename
              id
              url
              createdAt
              description
              isPrivate
              name
              languages(orderBy: {field: SIZE, direction: DESC}, first: 1) {
                __typename
                edges {
                  __typename
                  node {
                    __typename
                    name
                    color
                  }
                }
              }
              owner {
                __typename
                login
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "GetMyRepositories"

  public var first: Int
  public var last: Int

  public init(first: Int, last: Int) {
    self.first = first
    self.last = last
  }

  public var variables: GraphQLMap? {
    return ["first": first, "last": last]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("viewer", type: .nonNull(.object(Viewer.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(viewer: Viewer) {
      self.init(unsafeResultMap: ["__typename": "Query", "viewer": viewer.resultMap])
    }

    /// The currently authenticated user.
    public var viewer: Viewer {
      get {
        return Viewer(unsafeResultMap: resultMap["viewer"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("login", type: .nonNull(.scalar(String.self))),
          GraphQLField("repositories", arguments: ["first": GraphQLVariable("first"), "last": GraphQLVariable("last")], type: .nonNull(.object(Repository.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(login: String, repositories: Repository) {
        self.init(unsafeResultMap: ["__typename": "User", "login": login, "repositories": repositories.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The username used to login.
      public var login: String {
        get {
          return resultMap["login"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "login")
        }
      }

      /// A list of repositories that the user owns.
      public var repositories: Repository {
        get {
          return Repository(unsafeResultMap: resultMap["repositories"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "repositories")
        }
      }

      public struct Repository: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["RepositoryConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("edges", type: .list(.object(Edge.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "RepositoryConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["RepositoryEdge"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("node", type: .object(Node.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(node: Node? = nil) {
            self.init(unsafeResultMap: ["__typename": "RepositoryEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Repository"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("url", type: .nonNull(.scalar(String.self))),
                GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                GraphQLField("description", type: .scalar(String.self)),
                GraphQLField("isPrivate", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
                GraphQLField("languages", arguments: ["orderBy": ["field": "SIZE", "direction": "DESC"], "first": 1], type: .object(Language.selections)),
                GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, url: String, createdAt: String, description: String? = nil, isPrivate: Bool, name: String, languages: Language? = nil, owner: Owner) {
              self.init(unsafeResultMap: ["__typename": "Repository", "id": id, "url": url, "createdAt": createdAt, "description": description, "isPrivate": isPrivate, "name": name, "languages": languages.flatMap { (value: Language) -> ResultMap in value.resultMap }, "owner": owner.resultMap])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            /// The HTTP URL for this repository
            public var url: String {
              get {
                return resultMap["url"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "url")
              }
            }

            /// Identifies the date and time when the object was created.
            public var createdAt: String {
              get {
                return resultMap["createdAt"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "createdAt")
              }
            }

            /// The description of the repository.
            public var description: String? {
              get {
                return resultMap["description"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "description")
              }
            }

            /// Identifies if the repository is private or internal.
            public var isPrivate: Bool {
              get {
                return resultMap["isPrivate"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isPrivate")
              }
            }

            /// The name of the repository.
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            /// A list containing a breakdown of the language composition of the repository.
            public var languages: Language? {
              get {
                return (resultMap["languages"] as? ResultMap).flatMap { Language(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "languages")
              }
            }

            /// The User owner of the repository.
            public var owner: Owner {
              get {
                return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "owner")
              }
            }

            public struct Language: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["LanguageConnection"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("edges", type: .list(.object(Edge.selections))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(edges: [Edge?]? = nil) {
                self.init(unsafeResultMap: ["__typename": "LanguageConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// A list of edges.
              public var edges: [Edge?]? {
                get {
                  return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
                }
                set {
                  resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
                }
              }

              public struct Edge: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["LanguageEdge"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("node", type: .nonNull(.object(Node.selections))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(node: Node) {
                  self.init(unsafeResultMap: ["__typename": "LanguageEdge", "node": node.resultMap])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var node: Node {
                  get {
                    return Node(unsafeResultMap: resultMap["node"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "node")
                  }
                }

                public struct Node: GraphQLSelectionSet {
                  public static let possibleTypes: [String] = ["Language"]

                  public static var selections: [GraphQLSelection] {
                    return [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("name", type: .nonNull(.scalar(String.self))),
                      GraphQLField("color", type: .scalar(String.self)),
                    ]
                  }

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(name: String, color: String? = nil) {
                    self.init(unsafeResultMap: ["__typename": "Language", "name": name, "color": color])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The name of the current language.
                  public var name: String {
                    get {
                      return resultMap["name"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "name")
                    }
                  }

                  /// The color defined for the current language.
                  public var color: String? {
                    get {
                      return resultMap["color"] as? String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "color")
                    }
                  }
                }
              }
            }

            public struct Owner: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Organization", "User"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("login", type: .nonNull(.scalar(String.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public static func makeOrganization(login: String) -> Owner {
                return Owner(unsafeResultMap: ["__typename": "Organization", "login": login])
              }

              public static func makeUser(login: String) -> Owner {
                return Owner(unsafeResultMap: ["__typename": "User", "login": login])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The username used to login.
              public var login: String {
                get {
                  return resultMap["login"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "login")
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class ProfileQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Profile($login: String!) {
      user(login: $login) {
        __typename
        login
        name
        avatarUrl(size: 44)
      }
    }
    """

  public let operationName: String = "Profile"

  public var login: String

  public init(login: String) {
    self.login = login
  }

  public var variables: GraphQLMap? {
    return ["login": login]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("user", arguments: ["login": GraphQLVariable("login")], type: .object(User.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(user: User? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
    }

    /// Lookup a user by login.
    public var user: User? {
      get {
        return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "user")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("login", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("avatarUrl", arguments: ["size": 44], type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(login: String, name: String? = nil, avatarUrl: String) {
        self.init(unsafeResultMap: ["__typename": "User", "login": login, "name": name, "avatarUrl": avatarUrl])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The username used to login.
      public var login: String {
        get {
          return resultMap["login"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "login")
        }
      }

      /// The user's public profile name.
      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// A URL pointing to the user's public avatar.
      public var avatarUrl: String {
        get {
          return resultMap["avatarUrl"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "avatarUrl")
        }
      }
    }
  }
}

public final class SpecificRepositoryQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SpecificRepository($owner: String!, $name: String!) {
      repository(name: $name, owner: $owner) {
        __typename
        id
        url
        createdAt
        description
        isPrivate
        name
        owner {
          __typename
          login
          avatarUrl(size: 44)
        }
        languages(orderBy: {field: SIZE, direction: DESC}, first: 1) {
          __typename
          edges {
            __typename
            node {
              __typename
              name
              color
            }
          }
        }
      }
    }
    """

  public let operationName: String = "SpecificRepository"

  public var owner: String
  public var name: String

  public init(owner: String, name: String) {
    self.owner = owner
    self.name = name
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "name": name]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("repository", arguments: ["name": GraphQLVariable("name"), "owner": GraphQLVariable("owner")], type: .object(Repository.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Repository"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("url", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("isPrivate", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
          GraphQLField("languages", arguments: ["orderBy": ["field": "SIZE", "direction": "DESC"], "first": 1], type: .object(Language.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, url: String, createdAt: String, description: String? = nil, isPrivate: Bool, name: String, owner: Owner, languages: Language? = nil) {
        self.init(unsafeResultMap: ["__typename": "Repository", "id": id, "url": url, "createdAt": createdAt, "description": description, "isPrivate": isPrivate, "name": name, "owner": owner.resultMap, "languages": languages.flatMap { (value: Language) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// The HTTP URL for this repository
      public var url: String {
        get {
          return resultMap["url"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "url")
        }
      }

      /// Identifies the date and time when the object was created.
      public var createdAt: String {
        get {
          return resultMap["createdAt"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "createdAt")
        }
      }

      /// The description of the repository.
      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      /// Identifies if the repository is private or internal.
      public var isPrivate: Bool {
        get {
          return resultMap["isPrivate"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "isPrivate")
        }
      }

      /// The name of the repository.
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// The User owner of the repository.
      public var owner: Owner {
        get {
          return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "owner")
        }
      }

      /// A list containing a breakdown of the language composition of the repository.
      public var languages: Language? {
        get {
          return (resultMap["languages"] as? ResultMap).flatMap { Language(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "languages")
        }
      }

      public struct Owner: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Organization", "User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("login", type: .nonNull(.scalar(String.self))),
            GraphQLField("avatarUrl", arguments: ["size": 44], type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeOrganization(login: String, avatarUrl: String) -> Owner {
          return Owner(unsafeResultMap: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
        }

        public static func makeUser(login: String, avatarUrl: String) -> Owner {
          return Owner(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The username used to login.
        public var login: String {
          get {
            return resultMap["login"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "login")
          }
        }

        /// A URL pointing to the owner's public avatar.
        public var avatarUrl: String {
          get {
            return resultMap["avatarUrl"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "avatarUrl")
          }
        }
      }

      public struct Language: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["LanguageConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("edges", type: .list(.object(Edge.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "LanguageConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["LanguageEdge"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("node", type: .nonNull(.object(Node.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(node: Node) {
            self.init(unsafeResultMap: ["__typename": "LanguageEdge", "node": node.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var node: Node {
            get {
              return Node(unsafeResultMap: resultMap["node"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Language"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
                GraphQLField("color", type: .scalar(String.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String, color: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "Language", "name": name, "color": color])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The name of the current language.
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            /// The color defined for the current language.
            public var color: String? {
              get {
                return resultMap["color"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "color")
              }
            }
          }
        }
      }
    }
  }
}

public final class SearchQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Search($query: String!, $type: SearchType!, $count: Int!) {
      search(query: $query, type: $type, last: $count) {
        __typename
        edges {
          __typename
          node {
            __typename
            ... on User {
              id
              avatarUrl(size: 44)
              login
            }
            ... on Repository {
              id
              name
              createdAt
              description
              isPrivate
              url
              owner {
                __typename
                avatarUrl(size: 44)
                login
              }
              languages(orderBy: {field: SIZE, direction: DESC}, first: 1) {
                __typename
                edges {
                  __typename
                  node {
                    __typename
                    name
                    color
                  }
                }
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "Search"

  public var query: String
  public var type: SearchType
  public var count: Int

  public init(query: String, type: SearchType, count: Int) {
    self.query = query
    self.type = type
    self.count = count
  }

  public var variables: GraphQLMap? {
    return ["query": query, "type": type, "count": count]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("search", arguments: ["query": GraphQLVariable("query"), "type": GraphQLVariable("type"), "last": GraphQLVariable("count")], type: .nonNull(.object(Search.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(search: Search) {
      self.init(unsafeResultMap: ["__typename": "Query", "search": search.resultMap])
    }

    /// Perform a search across resources.
    public var search: Search {
      get {
        return Search(unsafeResultMap: resultMap["search"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "search")
      }
    }

    public struct Search: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["SearchResultItemConnection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("edges", type: .list(.object(Edge.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(edges: [Edge?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "SearchResultItemConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of edges.
      public var edges: [Edge?]? {
        get {
          return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
        }
      }

      public struct Edge: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["SearchResultItemEdge"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("node", type: .object(Node.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(node: Node? = nil) {
          self.init(unsafeResultMap: ["__typename": "SearchResultItemEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The item at the end of the edge.
        public var node: Node? {
          get {
            return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "node")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["App", "Discussion", "Issue", "MarketplaceListing", "Organization", "PullRequest", "Repository", "User"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLTypeCase(
                variants: ["User": AsUser.selections, "Repository": AsRepository.selections],
                default: [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                ]
              )
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public static func makeApp() -> Node {
            return Node(unsafeResultMap: ["__typename": "App"])
          }

          public static func makeDiscussion() -> Node {
            return Node(unsafeResultMap: ["__typename": "Discussion"])
          }

          public static func makeIssue() -> Node {
            return Node(unsafeResultMap: ["__typename": "Issue"])
          }

          public static func makeMarketplaceListing() -> Node {
            return Node(unsafeResultMap: ["__typename": "MarketplaceListing"])
          }

          public static func makeOrganization() -> Node {
            return Node(unsafeResultMap: ["__typename": "Organization"])
          }

          public static func makePullRequest() -> Node {
            return Node(unsafeResultMap: ["__typename": "PullRequest"])
          }

          public static func makeUser(id: GraphQLID, avatarUrl: String, login: String) -> Node {
            return Node(unsafeResultMap: ["__typename": "User", "id": id, "avatarUrl": avatarUrl, "login": login])
          }

          public static func makeRepository(id: GraphQLID, name: String, createdAt: String, description: String? = nil, isPrivate: Bool, url: String, owner: AsRepository.Owner, languages: AsRepository.Language? = nil) -> Node {
            return Node(unsafeResultMap: ["__typename": "Repository", "id": id, "name": name, "createdAt": createdAt, "description": description, "isPrivate": isPrivate, "url": url, "owner": owner.resultMap, "languages": languages.flatMap { (value: AsRepository.Language) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var asUser: AsUser? {
            get {
              if !AsUser.possibleTypes.contains(__typename) { return nil }
              return AsUser(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

          public struct AsUser: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["User"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("avatarUrl", arguments: ["size": 44], type: .nonNull(.scalar(String.self))),
                GraphQLField("login", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, avatarUrl: String, login: String) {
              self.init(unsafeResultMap: ["__typename": "User", "id": id, "avatarUrl": avatarUrl, "login": login])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            /// A URL pointing to the user's public avatar.
            public var avatarUrl: String {
              get {
                return resultMap["avatarUrl"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "avatarUrl")
              }
            }

            /// The username used to login.
            public var login: String {
              get {
                return resultMap["login"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "login")
              }
            }
          }

          public var asRepository: AsRepository? {
            get {
              if !AsRepository.possibleTypes.contains(__typename) { return nil }
              return AsRepository(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

          public struct AsRepository: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Repository"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
                GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                GraphQLField("description", type: .scalar(String.self)),
                GraphQLField("isPrivate", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("url", type: .nonNull(.scalar(String.self))),
                GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
                GraphQLField("languages", arguments: ["orderBy": ["field": "SIZE", "direction": "DESC"], "first": 1], type: .object(Language.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, name: String, createdAt: String, description: String? = nil, isPrivate: Bool, url: String, owner: Owner, languages: Language? = nil) {
              self.init(unsafeResultMap: ["__typename": "Repository", "id": id, "name": name, "createdAt": createdAt, "description": description, "isPrivate": isPrivate, "url": url, "owner": owner.resultMap, "languages": languages.flatMap { (value: Language) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            /// The name of the repository.
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            /// Identifies the date and time when the object was created.
            public var createdAt: String {
              get {
                return resultMap["createdAt"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "createdAt")
              }
            }

            /// The description of the repository.
            public var description: String? {
              get {
                return resultMap["description"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "description")
              }
            }

            /// Identifies if the repository is private or internal.
            public var isPrivate: Bool {
              get {
                return resultMap["isPrivate"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isPrivate")
              }
            }

            /// The HTTP URL for this repository
            public var url: String {
              get {
                return resultMap["url"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "url")
              }
            }

            /// The User owner of the repository.
            public var owner: Owner {
              get {
                return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "owner")
              }
            }

            /// A list containing a breakdown of the language composition of the repository.
            public var languages: Language? {
              get {
                return (resultMap["languages"] as? ResultMap).flatMap { Language(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "languages")
              }
            }

            public struct Owner: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Organization", "User"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("avatarUrl", arguments: ["size": 44], type: .nonNull(.scalar(String.self))),
                  GraphQLField("login", type: .nonNull(.scalar(String.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public static func makeOrganization(avatarUrl: String, login: String) -> Owner {
                return Owner(unsafeResultMap: ["__typename": "Organization", "avatarUrl": avatarUrl, "login": login])
              }

              public static func makeUser(avatarUrl: String, login: String) -> Owner {
                return Owner(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "login": login])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// A URL pointing to the owner's public avatar.
              public var avatarUrl: String {
                get {
                  return resultMap["avatarUrl"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "avatarUrl")
                }
              }

              /// The username used to login.
              public var login: String {
                get {
                  return resultMap["login"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "login")
                }
              }
            }

            public struct Language: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["LanguageConnection"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("edges", type: .list(.object(Edge.selections))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(edges: [Edge?]? = nil) {
                self.init(unsafeResultMap: ["__typename": "LanguageConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// A list of edges.
              public var edges: [Edge?]? {
                get {
                  return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
                }
                set {
                  resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
                }
              }

              public struct Edge: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["LanguageEdge"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("node", type: .nonNull(.object(Node.selections))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(node: Node) {
                  self.init(unsafeResultMap: ["__typename": "LanguageEdge", "node": node.resultMap])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var node: Node {
                  get {
                    return Node(unsafeResultMap: resultMap["node"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "node")
                  }
                }

                public struct Node: GraphQLSelectionSet {
                  public static let possibleTypes: [String] = ["Language"]

                  public static var selections: [GraphQLSelection] {
                    return [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("name", type: .nonNull(.scalar(String.self))),
                      GraphQLField("color", type: .scalar(String.self)),
                    ]
                  }

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(name: String, color: String? = nil) {
                    self.init(unsafeResultMap: ["__typename": "Language", "name": name, "color": color])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The name of the current language.
                  public var name: String {
                    get {
                      return resultMap["name"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "name")
                    }
                  }

                  /// The color defined for the current language.
                  public var color: String? {
                    get {
                      return resultMap["color"] as? String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "color")
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
