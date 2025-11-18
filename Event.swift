import Foundation

struct Event: Identifiable, Codable {
    let id = UUID()
    let name: String
    let location: String
    let time: String
    let foodsProvided: [String]
    let description: String
}
