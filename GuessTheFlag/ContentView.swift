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
            RadialGradient(stops:[
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Spacer()
                VStack(spacing: 30) {
                    VStack {
                        Text("Guess the Flag of")
                            .font(.title2.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(contries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.primary)
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
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(10)
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title2.bold())
                    .foregroundColor(.white)
            }
            .alert(scoreTilte, isPresented: $showingScore) {
                Button("Continue") {
                    askQuestion()
                }
            } message: {
                Text("Your score is: \(score)")
            }
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
