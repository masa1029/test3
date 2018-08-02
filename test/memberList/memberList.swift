import UIKit
import Alamofire
import SwiftyJSON

class memberList: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate {
    
    var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.tintColor = UIColor.white
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.white

        //ナビゲーションバー下線削除
       self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        extendedLayoutIncludesOpaqueBars = true
        
        let barImageView = searchBar.value(forKey: "_background") as! UIImageView
        barImageView.removeFromSuperview()
        
        searchBar.backgroundColor = UIColor(red: 0.149, green: 0.1882, blue: 0.2588, alpha: 1.0)
        searchBar.delegate = self

        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        titleList.delegate = self
        titleList.dataSource = self
        
        initializePullToRefresh()
        
        getJson()

        //空セル削除
        titleList.tableFooterView = UIView(frame: .zero)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.view.endEditing(true)
        searchBar.text = ""
        titleList.reloadData()
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = false
        self.view.endEditing(true)
        /*検索*/
    }
    
    @IBOutlet weak var naviItem: UINavigationItem!
    
    @IBOutlet weak var titleList: UITableView!
 
     var tableList:[String] = [];
     var tableListSubTitle:[String] = [];
    
    
     func getJson(){
     
     var name:String = "";
     var position:String = "";
        
     let url:String = "http://www3275ui.sakura.ne.jp/anabuki/05/get/json.php"
     Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON{ response in
        
             var i: Int = 0;
     
     switch response.result {
     case .success:
     let json: JSON = JSON(response.result.value ?? kill)
     while true {
        name = json[i]["name"].stringValue
     self.tableList.append(name)
        position = json[i]["position"].stringValue
     self.tableListSubTitle.append(position)
        let end = json[i + 1]["name"].stringValue
     if end == ""{
        if let tabItem = self.tabBarController?.tabBar.items?[0] {
            tabItem.badgeValue = String(i + 1)
        }
     break
     }
     i += 1
     }
     //テーブルを再読込
     self.titleList.reloadData()
     
     print("テーブルに格納したJSON：")
     print(self.tableList)
     
     case .failure(let error):
     print(error)
     }
     }
     }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! customCell

        cell.goodButton.tag = indexPath.row
        cell.cellTitle.text = tableList[indexPath.row]
        cell.cellSubTitle.text = tableListSubTitle[indexPath.row]
        
        self.goodCount2[tableList[indexPath.row]] = 0//いいねリミット
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    //セルが選択された時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        // 次の画面へ移動
        performSegue(withIdentifier: "toComment", sender: tableList[indexPath.row])
    }
    //値渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! pushComment
        nextVC.selectedName = sender as! String
    }
    //セルの選択を遷移先から戻ってきたときに解除
    override func viewWillAppear(_ animated: Bool) {
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        super.viewWillAppear(animated)

        if let indexPathForSelectedRow = titleList.indexPathForSelectedRow {
            titleList.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    
    let good:UIImage = UIImage(named:"like02")!
    let goodLock:UIImage = UIImage(named:"like_lock")!
    let goodActive:UIImage = (UIImage(named:"like_active"))!
    
    var goodCount2 = [String:Int]()//いいねリミット

    
    @IBAction func good(_ sender: Any) {
        
        let selectedGood:UIButton = sender as! UIButton
        
        //いいねリミット
        let s = tableList[selectedGood.tag]
        
        let daylikeCounter:Int = goodCount2[s]!
        
        if daylikeCounter == 0{
            selectedGood.setImage(self.good, for: UIControlState())//いいねリミット
        }
        
        if daylikeCounter <= 2{

        let alert: UIAlertController = UIAlertController(title: tableList[selectedGood.tag] + "さんに\n「いいね」しますか？", message: "", preferredStyle:  UIAlertControllerStyle.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            
            (action: UIAlertAction!) -> Void in
            //いいねリミット
            var a:Int = self.goodCount2[s]!
            a += 1
            self.goodCount2.updateValue(a, forKey: self.tableList[selectedGood.tag])
            
            self.postGood(didSelected:self.tableList[selectedGood.tag])
            self.alert(title: "「いいね」しました")
            //いいね画像切り替え
            if daylikeCounter <= 1{
            selectedGood.setImage(self.goodActive, for: UIControlState())
            }else{
            selectedGood.setImage(self.goodLock, for: UIControlState())
            }
            print(self.goodCount2)
        })
            
            
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
            (action: UIAlertAction!) -> Void in})
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
        
        }else{
            self.alert(title: "上限です")
        }
    }
    
    
    func alert(title: String){
        let alert: UIAlertController = UIAlertController(title: title, message: "", preferredStyle:  UIAlertControllerStyle.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            
            (action: UIAlertAction!) -> Void in
        })
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    //テーブル引っ張って更新
    private weak var refreshControl: UIRefreshControl!

    private func initializePullToRefresh() {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(onPullToRefresh(_:)), for: .valueChanged)
        titleList.addSubview(control)
        refreshControl = control
    }
    @objc private func onPullToRefresh(_ sender: AnyObject) {
        refresh()
    }
    private func stopPullToRefresh() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    // MARK: - Data Flow
    private func refresh() {
        
        tableList = [];
        tableListSubTitle = [];

        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 1.0)
            DispatchQueue.main.async {
                self.completeRefresh()
                self.getJson()
            }
        }
    }
    private func completeRefresh() {
        stopPullToRefresh()
        titleList.reloadData()
    }
    
    
    //いいね送信
    func postGood(didSelected: String) {
        let postName:String = didSelected
        let postString = "name=\(postName)"
        
        var request = URLRequest(url: URL(string: "http://www3275ui.sakura.ne.jp/anabuki/05/post/jsonPost.php")!)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
        })
        task.resume()
    }
    
}

