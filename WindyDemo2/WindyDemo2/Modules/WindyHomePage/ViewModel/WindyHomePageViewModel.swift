//
//  Created by Thuan Nguyen on 16/02/2022.
//

import Foundation
import UIKit

class WindyHomePageViewModel: NSObject
{
    var title: String? = "WindyHomePageView"
}

extension WindyHomePageViewModel: WindyHomePageViewModelInput {
    
}

extension WindyHomePageViewModel: WindyHomePageViewModelOutput {
    
    func getTitle() -> String? {
        return title
    }
}
