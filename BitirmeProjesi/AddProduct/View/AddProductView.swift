////
////  AddProductView.swift
////  BitirmeProjesi
////
////  Created by Ecem Öztürk on 10.06.2023.
////

import SwiftUI
import PhotosUI



enum Fruit: String, CaseIterable, Hashable {
    case apple = "Apple"
    case orange = "Orange"
    case banana = "Banana"
}

struct AddProductView: View {
    @State private var productName = ""
    @State private var description = ""
    @State private var condition = ""
    @State private var image = UIImage()
    @State private var showSheet = false
    
    @State private var fruits = [Bool](repeating: false, count: Fruit.allCases.count)
    @State private var selectedFruits: [Fruit] = []
    
    @State private var showActivityIndicator = false
    
    
    var body: some View {
        
        
        
        NavigationView {
            
            Form {
                Section(header: Text("Ürün Bilgileri:").font(.system(size: 15))) {
                    TextField("Ürün Adını Giriniz", text: $productName)
                    TextField("Ürün Açıklaması Giriniz", text: $description)
                    Picker("Ürünün Yenilik Durumu", selection: $condition) {
                        Text("Yeni").tag("Yeni")
                        Text("Kullanılmış").tag("Kullanılmış")
                        Text("Yenilenmiş").tag("Yenilenmiş")
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section {
                    VStack {
                        Text("Ürün Görseli Ekle")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(16)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .onTapGesture {
                                showSheet = true
                            }
                        
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .frame(height: 250)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(25)
                        }
                    }
                    .sheet(isPresented: $showSheet) {
                        // Pick an image from the photo library:
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                        
                    }
                }
                
                Section(header: Text("ÜRÜNÜN AİT OLDUĞY KATEGORİLERİ SEÇ:").font(.system(size: 15))) {
                    ForEach(Fruit.allCases, id: \.self) { fruit in
                        Toggle(isOn: self.bindingForFruit(fruit)) {
                            Text(fruit.rawValue)
                        }
                        .toggleStyle(CheckmarkToggleStyle())
                        .onChange(of: self.fruits[self.indexForFruit(fruit)]) { newValue in
                            if newValue {
                                selectedFruits.append(fruit)
                            } else {
                                if let index = selectedFruits.firstIndex(of: fruit) {
                                    selectedFruits.remove(at: index)
                                }
                            }
                        }
                    }
                }
                
                // MARK: Takas isteği Button
                Button(action: {
                    showActivityIndicator = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        showActivityIndicator = false
                    }
                }) {
                    if showActivityIndicator {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                ProgressView()
                                    .frame(width: 30, height: 30)
                                    .padding(.vertical, 15)
                                Spacer()
                            }
                            Spacer()
                        }
                    } else {
                        Text("ÜRÜNÜ EKLE")
                            .font(.custom(customFont, size: 20).bold())
                            .padding(.vertical, 20)
                            .frame(maxWidth:.infinity)
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 25, x:5,y:5)
                    }
                }
            }
            .navigationTitle("ÜRÜN EKLE")
            
        }
        
        
    }
    
    
    private func bindingForFruit(_ fruit: Fruit) -> Binding<Bool> {
        let index = indexForFruit(fruit)
        return Binding<Bool>(
            get: { self.fruits[index] },
            set: { self.fruits[index] = $0 }
        )
    }
    
    private func indexForFruit(_ fruit: Fruit) -> Int {
        Fruit.allCases.firstIndex(of: fruit) ?? 0
    }
}

struct CheckmarkToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Button(action: { withAnimation { configuration.$isOn.wrappedValue.toggle() }}){
                HStack{
                    configuration.label.foregroundColor(.primary)
                    Spacer()
                    if configuration.isOn {
                        Image(systemName: "checkmark").foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}

