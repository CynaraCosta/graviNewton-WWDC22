//
//  File.swift
//  GraviNewton
//
//  Created by Cynara Costa on 11/04/22.
//

import SwiftUI

struct InitPopUp : View {

    @Binding var show: Bool
    @Binding var blur: CGFloat
    
    var body: some View {
        
        if show{
            ZStack{
                
                Rectangle()
                    .fill(.white)
                    .frame(width: 398, height: 327, alignment: .center)
                    .transition(.scale)
                    .cornerRadius(20)
                
                VStack (spacing: -30) {
                    Text("Will Newton ever discover gravity?")
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                        .frame(width: 261, height: 117, alignment: .center)
                    
                    Text("Hi! Welcome to the year **1666**, when Newton was about to discover **gravity!** But would this still happen under other circumstances? How about **you test it yourself!** Just simulate gravity just below, and **click on the apple** to find out what would happen to Newton! Let's start?")
                        .font(.system(size: 13, weight: .regular, design: .default))
                        .multilineTextAlignment(.center)
                        .frame(width: 281, height: 173, alignment: .center)
                    
                    Button {
                        withAnimation{
                            show.toggle()
                            blur = 0.0
                        }
                    } label: {
                        Image("button")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                }
            }
        }
        
    }
}
