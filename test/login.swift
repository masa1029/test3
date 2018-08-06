import UIKit
import Alamofire
import SwiftyJSON

class login: UIViewController {

    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var password: UITextField!

    var userlist: [String]=[]
    var passlist:  [String]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .default

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreed.
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBAction func onClickRogin(_ sender: UIButton, forEvent event: UIEvent) {
        let name = user.text
        let pass = password.text
     
        if name != "" || pass != "" {
            print("ok")
            //__________________
             let url:String = "http://www3275ui.sakura.ne.jp/anabuki/05/get/json.php"
            
            Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON{ response in
                
                switch response.result {
                case .success:
                    let json:JSON = JSON(response.result.value ?? kill)
                    
                    let cot:Int=json.count
                    
                    for i in 0...cot {
                        var dbname:String=json[i]["name"].stringValue
                        var dbpass:String=json[i]["user_id"].stringValue
                        print(name )
                        if name == dbname && pass == dbpass {
                            print("ok")
//0802
                            // UserDefaults のインスタンス
                            let userDefaults = UserDefaults.standard
                            // デフォルト値
                            userDefaults.register(defaults: ["DataStore": dbname])
                            
                            // Keyを指定して保存
                            userDefaults.set(dbname, forKey: "DataStore")
                            // データの同期
                            userDefaults.synchronize()
                            
                            // Keyを指定して読み込み
                            let str: String = userDefaults.object(forKey: "DataStore") as! String
                         //  print(str)
                            // Key の値を削除
                            userDefaults.removeObject(forKey: "DataStore")
                            
                            
                            
 //
                            self.ok()
                        }
              
                   /*     self.userlist.append(nama)
                        self.passlist.append(pass)*/
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
            }
            //___
      
                }else {print("ng")}
        
    }
    
    func ok(){
  self.performSegue(withIdentifier: "loginok", sender: nil )
    }
        

}
