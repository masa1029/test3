import UIKit

class settings: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extendedLayoutIncludesOpaqueBars = true
        
        //タイトルの色
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        //戻る<の色
        navigationController?.navigationBar.tintColor = .white
        
        setTable.delegate = self
        setTable.dataSource = self
        
        setTable.tableFooterView = UIView(frame: .zero)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var setTable: UITableView!
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    var setList = ["ログアウト","通知"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "setItems", for: indexPath as IndexPath)
        // Cellに値を設定.
        cell.textLabel?.text = setList[indexPath.row]
        
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        super.viewWillAppear(animated)
        
        if let indexPathForSelectedRow = setTable.indexPathForSelectedRow {
            setTable.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
 
}
    


