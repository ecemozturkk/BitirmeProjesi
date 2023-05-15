//
//  LoginPage.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 15.05.2023.
//

import SwiftUI

struct LoginPageView: View {
    
    @StateObject var loginData: LoginRegisterPageModel = LoginRegisterPageModel()
    
    var body: some View {
        VStack {
            
            // MARK: -"Welcome back" text
            Text("Welcome\nback")
                .font(.custom(customFont, size: 55).bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: getRect().height / 5)
                .padding()
                .background(
                    ZStack {
                        gradientCircles
                    }
                )
            
            // MARK: -Login page form
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 15) {
                    Group {
                        Text( loginData.registerUser ? "Register" : "Login")
                            .font(.custom(customFont, size: 22).bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Image(systemName: loginData.isAuthenticated ? "lock.fill" : "lock.open")
                    }
                    
                    
                    // MARK: -Custom Text Field
                    email
                    
                    password
                    
                    // MARK: -Register Re-enter Password
                    rePassword
                    // MARK: -Register First Name
                    firstName
                    // MARK: -Register Last Name
                    lastName
                    // MARK: -Register Location
                    location
                    // MARK: -Forgot Password Button
                    Button {
                        loginData.ForgotPassword()
                    } label: {
                        Text("Forgot password?")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.blue)
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    // MARK: -Login/Register Button
                    Button {
                        if loginData.registerUser {
                            loginData.register()
                        } else {
                            loginData.login()
                        }
                    } label: {
                        Text(loginData.registerUser ? "Register" : "Login")
                            .font(.custom(customFont, size: 17).bold())
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.white)
                            .background(.blue)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x:5, y:5)
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                    
                    // MARK: -Register Button
                    Button {
                        withAnimation{
                            (loginData.registerUser.toggle())
                        }
                    } label: {
                        Text(loginData.registerUser ? "Back to login" : "Create Account")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.blue)
                    }
                    .padding(.top, 8)
                    
                    
                }.padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                // MARK: -Applying custom corners
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
        
        // MARK: - Clearing Data when Changes..
        .onChange(of: loginData.registerUser) { newValue in
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
        }
    }
    
    @ViewBuilder func CustomTextField (icon: String, title: String, hint: String, value: Binding<String>, showPassword:Binding<Bool>) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Label {
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue {
                SecureField(hint, text: value)
                    .padding(.top, 2)
            } else {
                TextField(hint, text: value)
                    .padding(.top, 2)
            }
            
            Divider()
                .background(Color.black.opacity(0.4))
            
            
        }
        
        // MARK: -Showing "Show" button for password
        .overlay(
            Group {
                if title.contains("Password") {
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.custom(customFont, size: 13).bold())
                            .foregroundColor(.blue)
                    })
                    .offset(y:8)
                }
            }
            ,alignment: .trailing
        )
        
    }
}


struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
private extension LoginPageView {
    
    // MARK: -Gradient Circle
    @ViewBuilder var gradientCircles : some View {
        
        LinearGradient(colors: [ Color.pink, Color.white.opacity(0.8), Color.green], startPoint: .top, endPoint: .bottom)
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(.trailing)
            .offset(y:-25)
            .ignoresSafeArea()
        
        Circle()
            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
            .frame(width: 30, height: 30)
            .blur(radius: 3)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(30)
        
        Circle()
            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
            .frame(width: 23, height: 23)
            .blur(radius: 2)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.leading, 30)
    }
    // MARK: - email
    @ViewBuilder var email : some View {
        CustomTextField(icon: "envelope", title: "Email", hint: "ornek@gmail.com", value: $loginData.email, showPassword:.constant(false))
            .padding(.top,30)
    }
    // MARK: - password
    @ViewBuilder var password : some View {
        CustomTextField(icon: "lock", title: "Password", hint: "12345678", value: $loginData.password, showPassword: $loginData.showPassword)
            .padding(.top,10)
    }
    
    
    @ViewBuilder var rePassword : some View {
        if loginData.registerUser {
            CustomTextField(icon: "lock", title: "Re-Password", hint: "12345678", value: $loginData.rePassword, showPassword: $loginData.showReEnterPassword)
                .padding(.top, 10)
        }
    }
    
    @ViewBuilder var firstName: some View {
        if loginData.registerUser {
            CustomTextField(icon: "lock", title: "First Name", hint: "John", value: $loginData.firstName, showPassword:.constant(false))
                .padding(.top, 10)
        }
    }
    
    @ViewBuilder var lastName: some View {
        if loginData.registerUser {
            CustomTextField(icon: "lock", title: "Last Name", hint: "Doe", value: $loginData.lastName, showPassword:.constant(false))
                .padding(.top, 10)
        }
    }
    @ViewBuilder var location: some View {
        if loginData.registerUser {
            CustomTextField(icon: "lock", title: "Location", hint: "New York", value: $loginData.location, showPassword:.constant(false))
                .padding(.top, 10)
        }
    }
}
