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
        wireFrame.viewController = view
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
    func doSelectLocation()
    func doRemoveLocationFromFavoriteList(_ location: LocationModel)
    func doSelectLocation(_ index: IndexPath)
    func doViewCurrentLocationDetail()
}

//========================= VIEW MODEL =================
//=======================================================
// MARK: 
// MARK: VIEW MODEL
protocol WindyHomePageViewModelInput: NSObjectProtocol {
    func doUpdateForecaseWeatherData(key: String, data: ForecastWeatherDataModel?)
    func doUpdateCurrentLocationWeatherData(data: LocationWeatherDataModel)
    func doAddFavorite(_ location: LocationModel)
    func doRemoveFavorite(_ location: LocationModel)
}

protocol WindyHomePageViewModelOutput: NSObjectProtocol {
    func getTitle() -> String?
    func getLastTimeStr() -> String?
    func getListLocationCount() -> Int
    func getCurrentLocationWeatherData() -> LocationWeatherDataModel?
    func getCurrentLocationForecastWeatherData() -> ForecastWeatherDataModel?
    func getLocation(index: Int) -> LocationModel?
    func getLocationForecastData(index: Int) -> ForecastWeatherDataModel?
    func getFavoriteList() -> [LocationModel]
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
    func doOpenSelectLocationScreen(listLocationSelected: [LocationModel])
    func doGoDetail(lat _lat: Double,
                    long _long: Double,
                    locationName _locationName: String,
                    isCurrentLocation _isCurrentLocation: Bool,
                    dataDetail: ForecastWeatherDataModel?) 
}

protocol WindyHomePageWireFrameOutput: NSObjectProtocol {
    func didSelectLocation(_ location: LocationModel)
}
