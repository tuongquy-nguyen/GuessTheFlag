//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by KET on 24/11/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var contries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        .shuffled()
    
    @State private var correctAnswer = Int.random(in: 0..<3)
    @State private var showingScore = false
    @State private var scoreTilte = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .orange, .indigo]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Guess the Flag of")
                        .font(.title2.weight(.heavy))
                        .foregroundColor(.white)
                    Text(contries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                        .foregroundColor(.white)
                }
                
                ForEach(0..<3) {number in
                    Button {
                        flaggTapped(number)
                    } label: {
                        Image(contries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(radius: 6)
                    }
                }
            }
        }
        .alert(scoreTilte, isPresented: $showingScore) {
            Button("Continue") {
                askQuestion()
            }
        } message: {
            Text("Your score is: \(score)")
        }
    }
    
    func flaggTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTilte = "Correct"
            score += 1
        } else {
            if score <= 0 {
                score = 0
            }
            else {
                score -= 1
            }
            scoreTilte = "Wrong"
        }
        showingScore = true
    }
    
    func askQuestion() {
        contries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
