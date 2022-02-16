//
//  Created by Thuan Nguyen on 16/02/2022.
//

import Foundation

class WindyHomePageWireFrame: NSObject
{
    weak var viewController: WindyHomePageView!
    weak var presenter: WindyHomePageWireFrameOutput?
}

extension WindyHomePageWireFrame: WindyHomePageWireFrameInput {
    func doOpenSelectLocationScreen() {
        SelectLocationViewController.doSelectLocation(from: viewController,
                                                      selectedLocationIds: [])
        { [weak self] (location: LocationModel) in
            self?.presenter?.didSelectLocation(location)
        }
    }
}
