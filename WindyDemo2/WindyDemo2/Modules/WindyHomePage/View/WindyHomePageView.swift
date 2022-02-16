//
//  Created by Thuan Nguyen on 16/02/2022.
//

import Foundation
import UIKit
import MGSwipeTableCell

class WindyHomePageView: BaseViewController
{
    var presenter: WindyHomePageViewOutput?
    weak var viewModel: WindyHomePageViewModelOutput!
    
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var tbvMain: UITableView?
    @IBOutlet var viewAddLocation: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblUpdate: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setUpView()
        doReloadView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidAppear()
    }
    
    // MARK:
    // MARK:  IBACTIONS
    @IBAction func btnAddPressed(_ sender: Any) {
        presenter?.doSelectLocation()
    }
    
    // MARK:
    // MARK:  METHODS
    func setUpView() {
        tbvMain?.tableFooterView = viewAddLocation
        tbvMain?.kAddPullToRefreshCustom { [weak self] in
            self?.presenter?.doPullToRefresh()
        }
    }
}

extension WindyHomePageView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        let count = viewModel.getListLocationCount()
        return count == 0 ? 1 : count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = HomeCurrenLocationTableViewCell.dequeCellWithTable(tableView)
            cell.billData(viewModel.getCurrentLocationWeatherData(), viewModel.getCurrentLocationForecastWeatherData())
            return cell
        }
        
        let count = viewModel.getListLocationCount()
        if count == 0 {
            let cell = NoDataTableViewCell.dequeCellWithTable(tableView)
            return cell
        }
        
        let cell = HomeLocationTableViewCell.dequeCellWithTable(tableView)
        let location = viewModel.getLocation(index: indexPath.row)
        let forecastData = viewModel.getLocationForecastData(index: indexPath.row)
        cell.billData(location, forecastData)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let count = viewModel.getListLocationCount()
        return indexPath.section == 0 ? 220.0 : (count == 0 ? 300.0 : 50.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension WindyHomePageView: MGSwipeTableCellDelegate {
    func swipeTableCell(_ cell: MGSwipeTableCell, canSwipe direction: MGSwipeDirection) -> Bool {
        return true
    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell, swipeButtonsFor direction: MGSwipeDirection, swipeSettings: MGSwipeSettings, expansionSettings: MGSwipeExpansionSettings) -> [UIView]? {
        
        if direction == MGSwipeDirection.rightToLeft {
            weak var weakSelf = self
            let delete = MGSwipeButton(title: LocalizationStringHelper.remove,
                                     icon: nil,
                                     backgroundColor: AppColor.redColor,
                                     padding: 18)
            { (item: MGSwipeTableCell) -> Bool in
                if let indexPath = weakSelf?.tbvMain?.indexPath(for: cell) {
                    weakSelf?.doRemoveFavorite(indexPath)
                }
                return true
            }
            
            return [delete]
        }
        
        return []
    }
    
    func doRemoveFavorite(_ indexPath: IndexPath) {
        guard let location = viewModel.getLocation(index: indexPath.row) else {
            return
        }
 
        let alert = UIAlertController(title: "Remove".localized + " \(location.name)",
                                      message: "Do you want remove from favorite list?".localized,
                                      preferredStyle: .alert)
        let actionRemove = UIAlertAction(title: "Remove".localized, style: .destructive) { [weak self] _ in
            self?.presenter?.doRemoveLocationFromFavoriteList(location)
        }
        
        let actionCancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        alert.addAction(actionRemove)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
}

extension WindyHomePageView: WindyHomePageViewInput {
    func doReloadView() {
        lblTitle?.text = viewModel.getTitle()
        lblUpdate?.text = viewModel.getLastTimeStr()
        tbvMain?.kPullToRefreshStopAnimation()
        tbvMain?.reloadData()
    }
    
    func doStopLoading() {
        tbvMain?.kPullToRefreshStopAnimation()
        tbvMain?.reloadData()
    }
}
