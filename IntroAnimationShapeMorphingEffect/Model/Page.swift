//
//  PageView.swift
//  IntroAnimationShapeMorphingEffect
//
//  Created by Abbas on 02/08/2024.
//

import SwiftUI

enum Page: String {
    case page1 = "Page1"
    case page2 = "Page2"
    case page3 = "Page3"
    case page4 = "Page4"
    
    
    var pageContent: String{
        switch self {
        case .page1: "calendar"
        case .page2: "magnifyingglass"
        case .page3: "chart.bar.xaxis"
        case .page4: "person"
        }
    }

    // next page  ?
     
    var nextPage: Page {
        switch self {
        case .page1: return .page2
        case .page2: return .page3
        case .page3: return .page4
        case .page4: return .page1
        }
    } 

    // previous page  ?
    var previousPage: Page {
        switch self {
        case .page1: return .page4
        case .page2: return .page1
        case .page3: return .page2
        case .page4: return .page3
        }
    }

    //skip page  ?
    var skipPage: Page {
        switch self {
        case .page1: return .page4
        case .page2: return .page4
        case .page3: return .page4
        case .page4: return .page4
        }
    }

    var index : CGFloat {
        switch self {
        case .page1: return 0
        case .page2: return 1
        case .page3: return 2
        case .page4: return 3
        }
    }
}


//    allCases 
extension Page {
    static var allCases: [Page] {
        return [.page1, .page2, .page3, .page4]
    }
}
