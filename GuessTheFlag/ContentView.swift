//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by KET on 24/11/2021.
//

import SwiftUI

struct FlagImage: View {
    var imageName = ""
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 6)
    }
}

struct myPro: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.bold))
            .foregroundStyle(.white)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3.weight(.semibold))
            .foregroundStyle(.ultraThinMaterial)
    }
}

extension View {
    func proStyle() -> some View {
        modifier(myPro())
    }
    
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    
    @State private var contries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        .shuffled()
    
    @State private var correctAnswer = Int.random(in: 0..<3)
    @State private var showingScore = false
    @State private var showingFinalScore = false
    @State private var scoreTilte = ""
    @State private var score = 0
    @State private var userChoice = ""
    @State private var playCount = 0
    @State private var rotateAmount = 0.0
    @State private var selectedFlag = -1
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops:[
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.78, green: 0.40, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .proStyle()
                
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
                    
                    ForEach(0..<3) { number in
                        Button {
                            flaggTapped(number)
                        } label: {
                            FlagImage(imageName: contries[number])
                        }
                        .opacity(selectedFlag == -1 || selectedFlag == number ? 1 : 0.25)
                        .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1 : 0.8)
                        .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                        .animation(.default, value: selectedFlag)
                        
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
                if scoreTilte == "Correct" {
                    Text("Your score has been increased to: \(score)")
                }
                else {
                    Text("Wrong! That's the flag of \(userChoice)")
                }
            }
            
            .alert(Text("Game Over"), isPresented: $showingFinalScore) {
                Button("Restart the game") {
                    reset()
                }
            } message: {
                Text("The test is done! Your final score is: \(score)")
            }
        }
    }
    
    func flaggTapped(_ number: Int) {
        selectedFlag = number
        playCount += 1
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
            scoreTilte = "Oops!"
        }
        showingScore = true
        
        if playCount >= 8 {
            showingFinalScore = true
        }
        userChoice = contries[number]
    }
    
    func askQuestion() {
        contries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        selectedFlag = -1
    }
    
    func reset() {
        score = 0
        playCount = 0
        askQuestion()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
