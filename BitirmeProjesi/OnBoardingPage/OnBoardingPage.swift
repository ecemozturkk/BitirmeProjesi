//
//  OnBoardingPage.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 15.05.2023.
//

import SwiftUI

let customFont = "Nunito-Regular"


struct OnBoardingPage: View {
    // Showing Login Page
    @State var showLoginPage : Bool = false
    
    
    var body: some View {
        VStack(alignment: .center) {
            Text("TAKASLA!")
                .font(.system (size: 55))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Image("onBoardingImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button{
                withAnimation {
                    showLoginPage = true
                }
            } label: {
                Text("Get started")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(.blue)
            }
            .padding(.horizontal, 30)
            //Adding some adjustments only for larger displays..
            .offset(y: getRect().height < 750 ? 20 : 40)
            .offset(y:20)
        }
        .padding()
        .padding(.top, getRect().height < 750 ? 20 : 0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        .overlay(
            Group {
                if showLoginPage {
                    LoginPageView().transition(.move(edge: .bottom))
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
