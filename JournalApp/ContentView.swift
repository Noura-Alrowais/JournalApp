//
//  ContentView.swift
//  JournalApp
//
//  Created by Noura Alrowais on 18/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    var body: some View {
        NavigationStack{
            ZStack{
                
                Rectangle().fill(.linearGradient(colors:[Color(hex:"#141420"), Color(hex:"#000000")], startPoint: .top, endPoint: .bottom)).ignoresSafeArea()
                VStack{
                    Image("book").resizable().scaledToFit().frame(width: 77.7, height: 101).padding(.top,304.77).padding(.bottom,457.23).padding(.leading, 162.15).padding(.trailing, 162.15).overlay(
                        Text("Journali")
                            .fontWeight(.black)
                            .foregroundColor(Color.white).font(.system(size: 42)).padding(.top, 24.23)).overlay(
                                Text("Your thoughts, your story").font(.system(size: 18)).foregroundColor(Color.white).padding(.top, 96.23))
                }
                
            }.ignoresSafeArea() .navigationDestination(isPresented: $isActive){
                mainpage()}  .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                        isActive = true
                    }
                    
                }
            
        }
    }
}

#Preview {
    ContentView()
}
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let rgbValue = UInt32(hex, radix: 16)
        let r = Double((rgbValue! & 0xFF0000) >> 16) / 255
        let g = Double((rgbValue! & 0x00FF00) >> 8) / 255
        let b = Double(rgbValue! & 0x0000FF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
