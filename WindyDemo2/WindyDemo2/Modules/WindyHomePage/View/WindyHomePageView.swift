//
//  Created by Thuan Nguyen on 16/02/2022.
//

import Foundation
import UIKit
import MGSwipeTableCell
import SVPullToRefresh

class WindyHomePageView: BaseViewController
{
    var presenter: WindyHomePageViewOutput?
    weak var viewModel: WindyHomePageViewModelOutput?
    
    @IBOutlet weak var tbvMain: UITableView!
    @IBOutlet var viewAddLocation: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblUpdate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    // MARK:
    // MARK:  IBACTIONS
    @IBAction func btnAddPressed(_ sender: Any) {
    }
    
    // MARK:
    // MARK:  METHODS
    func setUpView() {
        
    }
}

extension WindyHomePageView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HomeLocationTableViewCell.dequeCellWithTable(tableView)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
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
                if let indexPath = weakSelf?.tbvMain.indexPath(for: cell) {
                    weakSelf?.doRemoveFavorite(indexPath)
                }
                return true
            }
            
            return [delete]
        }
        
        return []
    }
    
    func doRemoveFavorite(_ indexPath: IndexPath) {
        let locationName = "Test"
        weak var weakSelf = self
        
        let alert = UIAlertController(title: "Remove".localized + " \(locationName)",
                                      message: "Do you want remove from favorite list?".localized,
                                      preferredStyle: .alert)
        let actionRemove = UIAlertAction(title: "Remove".localized, style: .destructive) { _ in
            if let strong = weakSelf {
                strong.tbvMain.reloadData()
            }
        }
        
        let actionCancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        alert.addAction(actionRemove)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
}

extension WindyHomePageView: WindyHomePageViewInput {
    
}
