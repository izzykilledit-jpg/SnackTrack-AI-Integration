import Foundation

struct UserProfile: Codable {
    var likedFoods: [String] = []
    var dislikedFoods: [String] = []
    var allergies: [String] = []
}
