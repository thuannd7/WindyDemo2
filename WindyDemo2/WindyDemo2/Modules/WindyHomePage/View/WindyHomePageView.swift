//
//  Created by Thuan Nguyen on 16/02/2022.
//

import Foundation
import UIKit

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
    
    // MARK:
    // MARK:  METHODS
    func setUpView() {
        self.navigationItem.title = viewModel?.getTitle()
    }
}

extension WindyHomePageView: WindyHomePageViewInput {
    
}
