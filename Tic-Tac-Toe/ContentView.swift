import SwiftUI

struct ContentView: View {
    @State private var board = Array(repeating: "", count: 9)
    @State private var currentPlayer = "X"
    @State private var winner: String?

    var body: some View {
        VStack {
            Text("Tic-Tac-Toe").font(.system(size: 48, weight: .bold)).padding()

            Text(winner ?? "Player \(currentPlayer)'s Turn")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.black)
                .padding()

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                ForEach(0..<9, id: \ .self) { index in
                    Button(action: {
                        makeMove(at: index)
                    }) {
                        Text(board[index])
                            .frame(width: 80, height: 80)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .font(.system(size: 40, weight: .bold))
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 4, x: 2, y: 2)
                    }
                    .disabled(!board[index].isEmpty || winner != nil)
                }
            }
            .padding()

            Button("Reset Game") {
                resetGame()
            }
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.white.ignoresSafeArea())
    }

    func makeMove(at index: Int) {
        if board[index].isEmpty {
            board[index] = currentPlayer
            if checkWin(for: currentPlayer) {
                winner = "Player \(currentPlayer) Wins!"
            } else if !board.contains("") {
                winner = "It's a Draw!"
            } else {
                currentPlayer = (currentPlayer == "X") ? "O" : "X"
            }
        }
    }

    func checkWin(for player: String) -> Bool {
        let winningCombos = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
            [0, 4, 8], [2, 4, 6]             // Diagonals
        ]
        return winningCombos.contains { combo in
            combo.allSatisfy { board[$0] == player }
        }
    }

    func resetGame() {
        board = Array(repeating: "", count: 9)
        currentPlayer = "X"
        winner = nil
    }
}

struct TicTacToeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
