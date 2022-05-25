import SwiftUI

// use the program in landscape right

struct ContentView: View {
    
    @State private var gravityValue: Float = 9.8
    @State var selectedApple = false
    @State private var blurAmount: CGFloat = 10.0
    @State private var initPopUp = true
    @State var shake = true
    @State private var grave = false
    @State private var sleepyNewton = true
    @State private var whatNewton = false
    @State private var newton = false
    @State private var idea = false
    @State var musicOn = true
    
    var body: some View {
        
        let velocity = velocity(gravity: gravityValue)
        let timeOfFall = timeToFall(velocity: velocity, gravity: gravityValue)
        let timeToWait = timeOfWaiting(velocity: velocity)
        
        ZStack {


            BackgroundView()
            
            ZStack{
                
                ZStack {
                    ImageGroundView(image: "ground")
                    VStack(spacing: 2){
                        Stepper("Enter a gravity value", value: $gravityValue, in: 0...130)
                            //.foregroundColor(Color("mediumGray"))
                            //.background(Color.white)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .regular, design: .default))
                            .frame(width: 280, height: 50, alignment: .center)
                            .cornerRadius(15)
                            .padding(.top, 20)
                        Text("The gravity at this place is **\(gravityValue, specifier: "%.2f") m/s²**")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .regular, design: .default))
                    }
                    .padding(.top, 300)
                }
                
                VStack(spacing: 30){
                    
                    PlanetButton(gravity: $gravityValue, title: "Earth", image: "earth")
                    PlanetButton(gravity: $gravityValue, title: "Moon", image: "moon")
                    PlanetButton(gravity: $gravityValue, title: "Jupiter", image: "jupiter")
                    
                }.padding(.leading, 700)
                
                VStack {
                    
                    ZStack{
                        
                        CloudView(paddingTop: 50.0, paddingLeading: 130.0, paddingBottom: 0.0, paddingTrailing: 0.0)
                        CloudView(paddingTop: 0.0, paddingLeading: 0.0, paddingBottom: 150.0, paddingTrailing: 600.0)
                        CloudView(paddingTop: 0.0, paddingLeading: 450.0, paddingBottom: 130.0, paddingTrailing: 0.0)
                        
                        Image("tree")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                            .padding(.trailing, 250)
                            .padding(.bottom, 27)
                        
                        if sleepyNewton{
                            Image("newton_mimindo")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                                .padding(.top, 150)
                                .padding(.trailing, 140)
                        }
                        
                        
                        if newton {
                            Image("newton")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                                .padding(.top, 150)
                                .padding(.trailing, 140)
                        }
                        
                        if whatNewton{
                            Image("newton_what")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                                .padding(.top, 150)
                                .padding(.trailing, 140)
                        }
                        
                        
                        if idea{
                            Image("idea")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .padding(.trailing, 140)
                                .padding(.bottom, 80)
                        }
                        
                        
                        
                        if grave{
                            Image("grave")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .padding(.top, 155)
                                .padding(.trailing, 135)
                        }
                        
                        
                        
                        HStack(spacing: 145){
                            
                            VStack (spacing: 200){
                                
                                Button{
                                    
                                    shake = false
                                    musicOn = false
                                    selectedApple.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(timeOfFall)){
                                        
                                        playSound(sound: "hitSound")
                                        
                                        if (velocity < 10) && (velocity >= 0){
                                            DispatchQueue.main.asyncAfter(deadline: .now() + timeToWait){
                                                blurAmount = 10.0
                                            }
                                        
                                        } else if (velocity >= 10) && (velocity < 20){
                                            
                                            sleepyNewton = false
                                            whatNewton = true
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                                whatNewton = false
                                                newton = true
                                                idea = true
                                                playSound(sound: "ideaSound")
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + timeToWait - 1.3){
                                                    blurAmount = 10.0
                                                    newton = false
                                                    idea = false
                                                    sleepyNewton = true
                                                }
                                                
                                            }
                                        
                                        } else {
                                            
                                            sleepyNewton = false
                                            grave = true
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + timeToWait + 0.3){
                                                blurAmount = 10.0
                                                grave = false
                                                sleepyNewton = true
                                            }
                                        
                                        }
                                        
                                    }
                                    
                                } label: {
                                    Image("apple")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .offset(y: selectedApple ? 120 : 0)
                                        .animation(.linear(duration: Double(timeOfFall)))

                                }
                                Text("")
                            }
                            Text("")
                        }
                    }
                }
            }.blur(radius: blurAmount)
            
            DiscoverPopUp(show: $selectedApple, blur: $blurAmount, music: $musicOn,velocity: velocity, gravity: gravityValue).transition(
                AnyTransition.asymmetric(
                    insertion: AnyTransition.opacity.animation(Animation.default.delay(Double(timeOfFall) + timeToWait + 1.0)),
                    removal: AnyTransition.opacity)
            )
            
            InitPopUp(show: $initPopUp, blur: $blurAmount)
            
        }.onAppear{
                playSound(sound: "graviNewtonBackgroundSound")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}

struct ImageGroundView: View {
    
    var image: String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 1000, height: 1000)
            .padding(.top, 330)
    }
}

struct BackgroundView: View {
    
    var colors = getColor(time: getDate())
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [colors.0, colors.1]),
                       startPoint: .bottomTrailing,
                       endPoint: .topLeading)
            .edgesIgnoringSafeArea(.all)
    }
}

struct CloudView: View{
    
    var paddingTop: CGFloat
    var paddingLeading: CGFloat
    var paddingBottom: CGFloat
    var paddingTrailing: CGFloat
    
    var body: some View {
        Image("cloud")
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .padding(.leading, paddingLeading)
            .padding(.top, paddingTop)
            .padding(.bottom, paddingBottom)
            .padding(.trailing, paddingTrailing)
    }
    
}


func getDate() -> Int{
     let time = Date()
     let timeFormatter = DateFormatter()
     timeFormatter.dateFormat = "HH"
     let stringDate = timeFormatter.string(from: time)
     let intDate = Int(stringDate)
     return intDate!
    }

func getColor(time: Int) -> (Color, Color) {
    
    var firstColor: Color
    var secondColor: Color
    
    if (4 <= time) && (time < 13) {
        firstColor = Color("mediumBlue")
        secondColor = Color("lightBlue")
    } else if (18 > time) && (time >= 13) {
        firstColor = Color("mediumYellow")
        secondColor = Color("lightYellow")
    } else {
        firstColor = .black
        secondColor = .gray
    }
    return (firstColor, secondColor)
}

func velocity(gravity: Float) -> Float{
    let velocity: Float = sqrt(2 * gravity * 10)
    return velocity
}

func timeToFall(velocity: Float, gravity: Float) -> Float{
    let timeToFall: Float = sqrt((2 * 10) / gravity)
    return timeToFall
}

func timeOfWaiting(velocity: Float) -> Double{
    
    var timeToWait: Double
    
    if (velocity < 10) && (velocity >= 0){
        
        timeToWait = 0.5
        
    } else if (velocity >= 10) && (velocity < 20){
        
        timeToWait = 2.5
        
    } else {
        
        timeToWait = 1.0
    }
    
    return timeToWait

}

// Credits
// I did the PixelArt all by myself at a browser program, so thanks to https://www.pixilart.com/ I could do that
// Also, did the music by myself, using the Garageband, messing around with the instruments and find out what would fit with the purpose of the game
