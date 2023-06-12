//
//  StaggeredGrid.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 25.05.2023.
//

import SwiftUI

struct StaggeredGrid<Content: View,T:Identifiable>: View where T: Hashable {
    var content: (T) -> Content
    var colums: Int
    var list: [T]
    var showIndicators: Bool
    var spacing: CGFloat
    init(colums:Int, showIndicators: Bool = false, spacing: CGFloat = 10, list: [T], @ViewBuilder content: @escaping (T) -> Content){
        self.content = content
        self.list = list
        self.showIndicators = showIndicators
        self.spacing = spacing
        self.colums = colums
    }
    func setUpList() -> [[T]]{
        var gridArray: [[T]] = Array(repeating:[], count: colums)
        var currentIndex: Int = 0
        for object in list{
            gridArray[currentIndex].append(object)
            if currentIndex == (colums - 1){
                currentIndex = 0
            } else{
                currentIndex += 1
            }
        }
        return gridArray
    }
    // Explanation of the setUpList() func
    /*
    let list = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    let colums = 3

    let gridArray = setUpList() // [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
     */

    var body: some View {
        HStack(alignment: .top, spacing: 20){
                ForEach(setUpList(), id: \.self){ columnsData in
                    LazyVStack(spacing: spacing){
                        ForEach(columnsData){object in
                            content(object)
                        }
                    }
                    .padding(.top, getIndex(values: columnsData) == 1 ? 30 : 0) // Arama sayfasında Sağ sütunun 30 birim aşağıda görünmesi
                }
            }
            .padding(.vertical)
    }
    // Moving Second row little down
    func getIndex(values: [T]) -> Int{
        let index = setUpList().firstIndex{ t in
            return t == values } ?? 0
        return index
    }
}

struct StaggeredGrid_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
