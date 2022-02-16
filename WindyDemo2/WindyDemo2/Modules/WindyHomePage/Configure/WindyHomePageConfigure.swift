//
//  Created by Thuan Nguyen on 16/02/2022.
//

import UIKit

class WindyHomePageConfigure: NSObject {

    class func viewController() -> WindyHomePageView {
        let view = WindyHomePageView.initWithDefaultNib()
        let presenter = WindyHomePagePresenter()
        let interactor = WindyHomePageInteractor()
        let wireFrame = WindyHomePageWireFrame()
        let viewModel = WindyHomePageViewModel()

        presenter.viewModel = viewModel
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame

        view.presenter = presenter
        view.viewModel = viewModel
        interactor.presenter = presenter
        wireFrame.presenter = presenter
        return view
    }
}

//===================== VIEW ============================
//=======================================================
// MARK: 
// MARK: VIEW
protocol WindyHomePageViewInput: NSObjectProtocol {

}

protocol WindyHomePageViewOutput: NSObjectProtocol {
    func viewDidLoad()
    func viewWillAppear()
}

//========================= VIEW MODEL =================
//=======================================================
// MARK: 
// MARK: VIEW MODEL
protocol WindyHomePageViewModelInput: NSObjectProtocol {

}

protocol WindyHomePageViewModelOutput: NSObjectProtocol {

    func getTitle() -> String?
}

//========================= INTERACTOR =================
//=======================================================
// MARK:
// MARK: INTERACTOR
protocol WindyHomePageInteractorInput: NSObjectProtocol {

}

protocol WindyHomePageInteractorOutput: NSObjectProtocol {

}

//========================= WIREFRAME =================
//=======================================================
// MARK:
// MARK: INTERACTOR
protocol WindyHomePageWireFrameInput: NSObjectProtocol {

}

protocol WindyHomePageWireFrameOutput: NSObjectProtocol {

}
