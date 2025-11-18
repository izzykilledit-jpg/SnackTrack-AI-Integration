import Foundation

class OpenAIClient {
    // ⚠️ Your API key goes here
    private let apiKey = "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"

    func askChat(systemPrompt: String, userMessage: String, completion: @escaping (String) -> Void) {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [
                ["role": "system", "content": systemPrompt],
                ["role": "user", "content": userMessage]
            ],
            "temperature": 0.7
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil, let data = data else {
                completion("Error: \(error?.localizedDescription ?? "unknown")")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    completion(content)
                } else {
                    completion("Error parsing response")
                }
            } catch {
                completion("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
