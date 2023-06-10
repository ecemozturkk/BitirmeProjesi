//
//  MediaFile.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 10.06.2023.
//

import SwiftUI

struct MediaFile: Identifiable {
    var id: String = UUID().uuidString
    var image: Image
    var data: Data
    
}


