//
//  Image.swift
//  IntroAnimationShapeMorphingEffect
//
//  Created by Abbas on 03/08/2024.
//

import SwiftUI

struct ImageModel: Identifiable {
    
    var id : UUID = .init()
    var image :String
    
}

var images :[ImageModel] = (1...8).compactMap({ImageModel (image: "Profile \($0)")})
