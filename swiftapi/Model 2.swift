import Foundation

public struct Recipe: Decodable, Equatable, Hashable {
    public let id: String
    public let name: String
    public let category: String?
    public let area: String?
    public let instructions: String?
    public let thumbnailURL: URL?

    public init(id: String, name: String, category: String?, area: String?, instructions: String?, thumbnailURL: URL?) {
        self.id = id
        self.name = name
        self.category = category
        self.area = area
        self.instructions = instructions
        self.thumbnailURL = thumbnailURL
    }

    // Convenience subtitle for list cells
    public var subtitle: String {
        [category, area].compactMap { $0 }.joined(separator: " • ")
    }
}
