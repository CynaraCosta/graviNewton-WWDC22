//
//  File.swift
//  GraviNewton
//
//  Created by Cynara Costa on 12/04/22.
//

import SwiftUI

struct DiscoverPopUp: View {
    
    @Binding var show: Bool
    @Binding var blur: CGFloat
    @Binding var music: Bool
    
    
    var velocity: Float
    var gravity: Float
    
    var body: some View {
    
        let title = discovered(velocityValue: velocity, gravityValue: gravity).0
        let textResult = discovered(velocityValue: velocity, gravityValue: gravity).1
        
        if show{
            
            ZStack{
                
                Rectangle()
                    .fill(.white)
                    .frame(width: 398, height: 327, alignment: .center)
                    .transition(.scale)
                    .cornerRadius(20)
                
                VStack (spacing: -30) {
                    Text(title)
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                        .frame(width: 261, height: 117, alignment: .center)
                    
                    Text(.init(textResult))
                        .font(.system(size: 13, weight: .regular, design: .default))
                        .multilineTextAlignment(.center)
                        .frame(width: 281, height: 173, alignment: .center)
                        .padding(.bottom, 20)
                    
                    Button {
                        withAnimation{
                            show.toggle()
                            blur = 0.0
                            music = true
                            playSound(sound: "graviNewtonBackgroundSound")
                        }
                    } label: {
                        Text("Try Again!")
                            .font(.system(size: 15, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                            .contentShape(Rectangle())
                            .frame(width: 175, height: 40, alignment: .center)
                            .background(Color("buttonOrange"))
                            .cornerRadius(10)
                            .padding(.bottom, 20)
                    }
                }
            }
        }
        
    }
}

func discovered(velocityValue: Float, gravityValue: Float) -> (String, String){
    
    var textResult: String
    var title: String
        
    let roundedVelocity = round(velocityValue * 100) / 100.0
    
    if (velocityValue < 10) && (velocityValue >= 0){
        
        title = "Newton did not discover gravity!"
        textResult = "That's because with gravity **\(gravityValue) m/s²**, the speed was **\(roundedVelocity) m/s**, which is not enough for him to feel a slight pain with the apple falling on his head, not making him wake up and think about the famous and well-known gravity!"
    
    } else if (velocityValue >= 10) && (velocityValue < 20){
        
        title = "Newton discovered gravity!"
        textResult = "That's because with gravity **\(gravityValue) m/s²**, the speed was **\(roundedVelocity) m/s**, which is enough for him to feel a slight pain with the apple falling on his head, making him wake up and think about the famous and well-known gravity!"
    
    } else {
        title = "Newton did not discover gravity!"
        textResult = "That's because with gravity **\(gravityValue) m/s²**, the speed was **\(roundedVelocity) m/s**, which is enough to make him lose his mind, literally!"
    
    }
    
    return (title, textResult)
}
