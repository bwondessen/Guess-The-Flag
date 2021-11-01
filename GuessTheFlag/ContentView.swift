//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Bruke on 10/5/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score: Double = 0
    @State private var question: Double = 0
    @State private var correctAnswers: Double = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        question += 1
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 1)
                    }
                }
                
                Text("\(score, specifier: "%.2f")")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score, specifier: "%.2f")%"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            
            correctAnswers += 1
            score = (correctAnswers / question) * 100
        } else {
            scoreTitle = "Incorrect, that's the flag of \(countries[number])"
            
            score = (correctAnswers / question) * 100
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
