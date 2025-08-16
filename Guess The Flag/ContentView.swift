//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Roshin Nishad on 8/16/25.
//

import SwiftUI

struct ContentView: View {
  @State private var showingScore = false
  @State private var showingGameEnd = false
  @State private var scoreTitle = ""
  @State private var scoreMessage = ""
  @State private var countries = [
    "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland",
    "Spain", "UK", "Ukraine", "US",
  ].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  @State private var score = 0
  @State private var gameCount = 0

  var body: some View {
    ZStack {
      LinearGradient(
        colors: [.indigo, .black],
        startPoint: .top,
        endPoint: .bottom
      )
      VStack {
        Text("Guess The Flag").font(.largeTitle.bold()).fontDesign(.rounded)
        Spacer().frame(height: 30)
        VStack(spacing: 25) {
          VStack {
            Text("Tap the flag of").fontWeight(.medium).font(.headline)
            Text(countries[correctAnswer]).fontWidth(.expanded).font(
              .largeTitle
            )
            .fontWeight(.bold)
          }
          ForEach(0..<3) { number in
            Button {
              flagTapped(number)
            } label: {
              Image(countries[number]).cornerRadius(16).overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                  .stroke(.white.gradient, lineWidth: 2)
              ).shadow(radius: 5)
            }
          }
        }
        Spacer().frame(height: 30)
        Text("Your score is: \(score)").fontWeight(.medium).fontWidth(.expanded)
      }.padding()
    }.ignoresSafeArea().alert(scoreTitle, isPresented: $showingScore) {
      Button("Next Game", action: newGame)
    } message: {
      Text(scoreMessage)
    }.alert("Game Complete", isPresented: $showingGameEnd) {
      Button("Restart Game", action: restartGame)
    } message: {
      Text("You scored \(score) out of 8.")
    }
  }

  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      score += 1
      scoreTitle = "Correct"
      scoreMessage = "Your score is now \(score)."
    } else {
      scoreTitle = "Wrong"
      scoreMessage = "That is actually the flag of \(countries[number])."
    }
    showingScore = true
  }

  func newGame() {
    gameCount += 1
    if gameCount == 8 {
      showingGameEnd = true
      return
    }
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }

  func restartGame() {
    newGame()
    gameCount = 0
    score = 0
  }

}
#Preview {
  ContentView()
}
