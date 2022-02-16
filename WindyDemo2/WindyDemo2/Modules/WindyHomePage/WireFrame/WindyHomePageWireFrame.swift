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
    func doOpenSelectLocationScreen(listLocationSelected: [LocationModel]) {
        let ids = listLocationSelected.map { (item: LocationModel) in
            return item.id
        }
        
        SelectLocationViewController.doSelectLocation(from: viewController,
                                                      selectedLocationIds: ids)
        { [weak self] (location: LocationModel) in
            self?.presenter?.didSelectLocation(location)
        }
    }
}
