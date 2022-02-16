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
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        presenter.view = view

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
    func doStopLoading()
    func doReloadView()
}

protocol WindyHomePageViewOutput: NSObjectProtocol {
    func viewDidLoad()
    func viewDidAppear()
    func doPullToRefresh()
}

//========================= VIEW MODEL =================
//=======================================================
// MARK: 
// MARK: VIEW MODEL
protocol WindyHomePageViewModelInput: NSObjectProtocol {
    func doUpdateLastTime()
    func doUpdateForecaseWeatherData(key: String, data: ForecastWeatherDataModel?)
    func didUpdateCurrentLocationWeatherData(data: LocationWeatherDataModel)
}

protocol WindyHomePageViewModelOutput: NSObjectProtocol {
    func getTitle() -> String?
    func getLastTimeStr() -> String?
    func getListLocationCount() -> Int
    func getCurrentLocationWeatherData() -> LocationWeatherDataModel?
    func getCurrentLocationForecastWeatherData() -> ForecastWeatherDataModel?
    func getWeatherData(location: LocationModel) -> LocationWeatherDataModel?
}

//========================= INTERACTOR =================
//=======================================================
// MARK:
// MARK: INTERACTOR
protocol WindyHomePageInteractorInput: NSObjectProtocol {
    func doGetCurrentLocationData(_ lat: Double, _ long: Double)
    func doGetForecastWeatherData(key: String, _ lat: Double, _ long: Double)
}

protocol WindyHomePageInteractorOutput: NSObjectProtocol {
    func didGetForecastWeatherData(key: String, data: ForecastWeatherDataModel)
    func didCurrentLocationWeatherData(data: LocationWeatherDataModel)
    func didRequestFailed(err: Error)
}

//========================= WIREFRAME =================
//=======================================================
// MARK:
// MARK: INTERACTOR
protocol WindyHomePageWireFrameInput: NSObjectProtocol {

}

protocol WindyHomePageWireFrameOutput: NSObjectProtocol {

}
