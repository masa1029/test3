import UIKit

class timeline: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extendedLayoutIncludesOpaqueBars = true
        
        //タイトルの色
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        //戻る<の色
        navigationController?.navigationBar.tintColor = .white
        
        timelineTable.tableFooterView = UIView(frame: .zero)
        
        // Do any additional setup after loading the view.
        
    }
    @IBOutlet weak var timelineTable: UITableView!
}
