import Foundation

class SnackTrackChatbot {
    private let client: OpenAIClient
    private var events: [Event]
    private var userProfile: UserProfile

    init(client: OpenAIClient) {
        self.client = client
        // Mock event data
        self.events = [
            Event(name: "Pizza Social", location: "Student Center", time: "12PM", foodsProvided: ["Pizza", "Soda"], description: "Free pizza for students!"),
            Event(name: "Burrito Bash", location: "Engineering Quad", time: "1PM", foodsProvided: ["Burritos"], description: "Delicious burritos!"),
            Event(name: "Vegan Lunch", location: "Library Courtyard", time: "12:30PM", foodsProvided: ["Vegan Wraps"], description: "Healthy vegan food!")
        ]
        self.userProfile = UserProfile()
    }

    func askAI(question: String, completion: @escaping (String) -> Void) {
        // Prepare system prompt
        let systemPrompt = """
        You are SnackTrack AI, assisting UTD students to find free food events.
        Use user preferences and allergies to recommend events.
        User preferences: \(userProfile.likedFoods)
        User dislikes: \(userProfile.dislikedFoods)
        User allergies: \(userProfile.allergies)
        Events: \(events.map { $0.name + " (" + $0.foodsProvided.joined(separator: ", ") + ")" })
        """
        client.askChat(systemPrompt: systemPrompt, userMessage: question) { response in
            completion(response)
        }
    }
}
