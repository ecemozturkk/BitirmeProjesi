//
//  OnBoardingPage.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 15.05.2023.
//

import SwiftUI

let customFont = "Nunito-Regular"

struct OnBoardingStep {
    let image: String
    let title: String
    let description: String
    
}

private let onBoardingSteps = [
    OnBoardingStep(image: "onboarding1", title: "TAKASLA'YA HOŞ GELDİN!", description: "Seni aramızda görmekten çok mutluyuz :)"),
    OnBoardingStep(image:"onboarding2" , title: "TAKASLAMAK ARTIK ÇOK KOLAY", description: "Beğendiğin ürünleri seç, takaslamak istediğin ürünleri ekle"),
    OnBoardingStep(image: "onboarding3", title: "HAZIRSAN TAKASLAMAYA BAŞLA!", description: "Üye ol ve takaslamanın keyfini çıkar")
]


struct OnBoardingPage: View {
    // Showing Login Page
    @State var showLoginPage : Bool = false // SİLME
    
    @State private var currentStep = 0
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                
                Button {
                    self.currentStep = onBoardingSteps.count - 1
                } label: {
                    Text("Atla").padding(16).foregroundColor(.gray)
                }
                
                
                
                
            }
            
            
            TabView(selection: $currentStep) {
                
                ForEach(0..<onBoardingSteps.count) { it in
                    
                    VStack {
                        Image(onBoardingSteps[it].image)
                            .resizable()
                            .frame(width: 250, height: 250)
                        Text(onBoardingSteps[it].title)
                            .multilineTextAlignment(.center)
                            .font(.custom(customFont, size: 26).bold())
                            .foregroundColor(Color.purple)
                            .bold()
                        Text(onBoardingSteps[it].description)
                            .multilineTextAlignment(.center)
                            .font(.custom(customFont, size: 18))
                            .padding(.horizontal, 32)
                            .padding(.top, 16)
                        
                    }
                    .tag(it)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            
            HStack {
                ForEach(0..<onBoardingSteps.count) { it in
                        if it == currentStep {
                            Rectangle()
                                .frame(width: 20, height: 10)
                                .cornerRadius(10)
                                .foregroundColor(.purple)
                        } else {
                            Circle()
                                .frame(width: 10, height:10)
                                .foregroundColor(.gray)
                        }
                }
            }
            .padding(.bottom, 24)
            
            
            
            Button(action: {
                if self.currentStep < onBoardingSteps.count - 1 {
                    self.currentStep += 1
                } else {
                    withAnimation {
                                        showLoginPage = true
                                    }
                }
            }) {
                Text(currentStep < onBoardingSteps.count - 1 ? "İlerle" : "Başla")
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
                    .foregroundColor(.white).bold()
            }

        }
        .overlay(Group {
            if showLoginPage {
                LoginPageView()
            }
        }
        )
    }

}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
    }
}

// Extending View to get Screen Bounds..
extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
