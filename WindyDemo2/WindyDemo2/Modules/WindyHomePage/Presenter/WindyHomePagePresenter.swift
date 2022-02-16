//
//  Created by Thuan Nguyen on 16/02/2022.
//

import Foundation
import UIKit

class WindyHomePagePresenter: NSObject
{
    weak var view: WindyHomePageViewInput?
    weak var interactor: WindyHomePageInteractorInput?
    weak var wireFrame: WindyHomePageWireFrameInput?
    var viewModel: WindyHomePageViewModel?
}

// MARK:
// MARK: VIEW
extension WindyHomePagePresenter: WindyHomePageViewOutput {
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        
    }
}

// MARK:
// MARK: INTERACTOR
extension WindyHomePagePresenter: WindyHomePageInteractorOutput {
    
}

// MARK:
// MARK: WIRE FRAME
extension WindyHomePagePresenter: WindyHomePageWireFrameOutput {
    
}
