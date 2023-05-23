//
//  ContentView.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 15.05.2023.
//

import SwiftUI

struct ContentView: View {
    // Log Status
    @AppStorage("log_Status") var log_Status: Bool = false
    var body: some View {
        Group {
            if log_Status {
                MainPageView()
            } else {
                OnBoardingPage()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//enum Fruit: String, CaseIterable, Hashable {
//    case apple = "Apple"
//    case orange = "Orange"
//    case banana = "Banana"
//}
//
//struct ContentView: View {
//
//    @State var fruits = [Bool](repeating: false, count: Fruit.allCases.count)
//
//    @State var selectedFruits: [Fruit] = []
//
//
//    var body: some View {
//        VStack {
//            Group {
//                Form{
//                    ForEach(0..<fruits.count, id:\.self){i in
//                        Toggle(isOn: self.$fruits[i]){
//                            Text(Fruit.allCases[i].rawValue)
//                        }
//                        .toggleStyle(CheckmarkToggleStyle())
//                        .onChange(of: self.fruits[i]) { newValue in
//                            if newValue {
//                                selectedFruits.append(Fruit.allCases[i])
//                            } else {
//                                if let index = selectedFruits.firstIndex(of: Fruit.allCases[i]) {
//                                    selectedFruits.remove(at: index)
//                                }
//                            }
//                        }
//                    }
//                }
//                .frame(maxHeight: 200)
//                .border(Color.gray)
//            }
//            Text("Seçilen Meyveler: \(selectedFruits.map { $0.rawValue }.joined(separator: ", "))")
//        }
//    }
//}
//
//struct CheckmarkToggleStyle: ToggleStyle {
//    func makeBody(configuration: Self.Configuration) -> some View {
//        HStack {
//            Button(action: { withAnimation { configuration.$isOn.wrappedValue.toggle() }}){
//                HStack{
//                    configuration.label.foregroundColor(.primary)
//                    Spacer()
//                    if configuration.isOn {
//                        Image(systemName: "checkmark").foregroundColor(.primary)
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
