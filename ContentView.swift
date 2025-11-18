import SwiftUI

struct ContentView: View {
    @State private var userQuestion = "What free food is on campus today?"
    @State private var aiResponse = "AI response will appear here..."

    private let client = OpenAIClient()
    private let chatbot: SnackTrackChatbot

    init() {
        self.chatbot = SnackTrackChatbot(client: client)
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("SnackTrack AI")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.red)
                .padding(.top, 30)

            TextField("Ask a question...", text: $userQuestion)
                .padding()
                .background(Color.yellow.opacity(0.3))
                .cornerRadius(10)
                .padding(.horizontal)

            Button(action: {
                chatbot.askAI(question: userQuestion) { response in
                    DispatchQueue.main.async {
                        self.aiResponse = response
                    }
                }
            }) {
                Text("Ask AI")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            ScrollView {
                Text(aiResponse)
                    .padding()
                    .background(Color.yellow.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ContentView()
}
