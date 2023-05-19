//
//  ProductsView.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 19.05.2023.
//

import SwiftUI

struct ProductsView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @StateObject private var viewModel = ProductsViewModel()

    @State private var shouldShowCreate = false
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.products, id:\.id) { product in
                            NavigationLink {
                                ProductDetailView(productId: product.id!) // .id şeklinde yazdı videoda
                            } label: {
                                ProductItemView(product: product)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Products")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                }
            }
            .onAppear{
                viewModel.fetchProducts()
            }
            .sheet(isPresented: $shouldShowCreate) {
                CreateProductView()
            }
            .alert(isPresented: $viewModel.hasError, error: viewModel.error) {
                Button("Retry") {
                    viewModel.fetchProducts()
                }
            }
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}

private extension ProductsView {
    var background: some View {
        Theme.lightWhite.ignoresSafeArea(edges: .top)

    }
    var create: some View {
        Button {
            shouldShowCreate.toggle()
        } label: {
            Image(systemName: "plus").font(.system(.headline, design: .rounded).bold())
        }

    }
}
