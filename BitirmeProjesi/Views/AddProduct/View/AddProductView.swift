////
////  AddProductView.swift
////  BitirmeProjesi
////
////  Created by Ecem Öztürk on 10.06.2023.
////

import SwiftUI
import PhotosUI



enum Category: String, CaseIterable, Hashable {
    case elektronik = "Elektronik"
    case giyim = "Giyim"
    case spor = "Spor"
    case hobi = "Hobi"
    case bahçe = "Bahçe"
    case diğer = "Diğer"
    
}

struct AddProductView: View {
    @State private var productName = ""
    @State private var description = ""
    @State private var condition = ""
    @State private var image = UIImage()
    @State private var showSheet = false
    
    @State private var categories = [Bool](repeating: false, count: Category.allCases.count)
    @State private var selectedCategories: [Category] = []
    
    @State private var showActivityIndicator = false
    
    @State private var showAlert = false
    
    var body: some View {
        
        
        
        VStack {
            NavigationView {
                
                Form {
                    Section(header: Text("Ürün Bilgileri:").font(.system(size: 15))) {
                        TextField("Ürün Adını Giriniz", text: $productName)
                        TextField("Ürün Açıklaması Giriniz", text: $description)
                        Picker("Ürünün Yenilik Durumu", selection: $condition) {
                            Text("Yeni/Etiketli").tag("Yeni/Etiketli")
                            Text("Az Kullanılmış").tag("Az Kullanılmış")
                            Text("Kullanılmış").tag("Kullanılmış")
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    Section {
                        VStack {
                            Text("Ürün Görseli Ekle")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background( LinearGradient(
                                    gradient: Gradient(colors: [Color.gray, Color(.lightGray)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                ))
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
                    
                    Section(header: Text("ÜRÜNÜN AİT OLDUĞU KATEGORİLERİ SEÇ:").font(.system(size: 15))) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Toggle(isOn: self.bindingForCategory(category)) {
                                Text(category.rawValue)
                            }
                            .toggleStyle(CheckmarkToggleStyle())
                            .onChange(of: self.categories[self.indexForCategory(category)]) { newValue in
                                if newValue {
                                    selectedCategories.append(category)
                                } else {
                                    if let index = selectedCategories.firstIndex(of: category) {
                                        selectedCategories.remove(at: index)
                                    }
                                }
                            }
                        }
                    }
                    
                    // MARK: Ürün ekle button
                    Button(action: {
                        showActivityIndicator = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            showActivityIndicator = false
                            
                            // Ürün ekleme işlemleri tamamlandı, uyarıyı göster
                            showAlert = true
                            
                            // 2 saniye sonra uyarıyı kapat
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                showAlert = false
                            }
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
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.gray, Color(.lightGray)]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.3), radius: 25, x: 5, y: 5)
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Başarılı"),
                            message: Text("Ürün ekleme işlemi başarıyla tamamlandı."),
                            dismissButton: .default(Text("Tamam"))
                        )
                    }
                }
                .navigationTitle("ÜRÜN EKLE")
                
            }
            
        }
        .background(
            Theme.lightWhite
            .ignoresSafeArea()
        )
        
        
    }
    
    
    private func bindingForCategory(_ category: Category) -> Binding<Bool> {
        let index = indexForCategory(category)
        return Binding<Bool>(
            get: { self.categories[index] },
            set: { self.categories[index] = $0 }
        )
    }
    
    private func indexForCategory(_ category: Category) -> Int {
        Category.allCases.firstIndex(of: category) ?? 0
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
