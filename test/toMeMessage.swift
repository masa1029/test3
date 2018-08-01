import UIKit

class toMeMessage: UIViewController,UITableViewDelegate {
    
    

override func viewDidLoad() {
    super.viewDidLoad()
    
    extendedLayoutIncludesOpaqueBars = true
    
    //タイトルの色
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    //戻る<の色
    navigationController?.navigationBar.tintColor = .white
    
    toMeTable.tableFooterView = UIView(frame: .zero)
    
    // Do any additional setup after loading the view.
    
}
    @IBOutlet weak var toMeTable: UITableView!
}
