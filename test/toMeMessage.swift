import UIKit
import Alamofire
import SwiftyJSON


class toMeMessage: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate{


    let str2 = ["sss","sss2"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return str2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toMeTable") as! mymessage
        
        cell.from!.text = str2[indexPath.row]
        
        return cell
    }
    
    
    func set(){
        var aaa: [String] = [] //comment
        let userDefaults = UserDefaults.standard
        userDefaults.synchronize()
        // Keyを指定して読み込み
        let str: String = userDefaults.object(forKey: "DataStore") as! String//name_id
        
        Alamofire.request("http://www3275ui.sakura.ne.jp/anabuki/05/get/GetComment.php", method: .post, parameters: ["name_id":str]).responseString(completionHandler: { response in
            
            
            
            print(str , "宛に届いたコメント" , response.value)
        })
    
    }
    
override func viewDidLoad() {
    //0802
    super.viewDidLoad()
    self.set()
   
    
    //_______________
    extendedLayoutIncludesOpaqueBars = true
    //aaaaaa
    //タイトルの色
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    //戻る<の色
    navigationController?.navigationBar.tintColor = .white
    
    toMeTable.tableFooterView = UIView(frame: .zero)
    
    // Do any additional setup after loading the view.
    
}
    @IBOutlet weak var toMeTable: UITableView!
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
