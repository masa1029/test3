//tst3
//  pushComment.swift
//
//
//  Created by きしもつ on 2018/07/25.
//

import UIKit
import Alamofire


class pushComment: UIViewController, UINavigationControllerDelegate {
    
    var selectedName:String!
    
    @IBOutlet weak var pushCommentTitle: UINavigationItem!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extendedLayoutIncludesOpaqueBars = true
        /*
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
         self.textView.becomeFirstResponder()
         }
         */
        navigationController?.delegate = self
        
        self.navigationItem.title = selectedName
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func pushComment(_ sender: Any) {
        
        if self.textView.text! == ""{
            self.textViewErr(errContents: "コメントが入力されていません")
        }else if self.textView.text!.count < 10{
            self.textViewErr(errContents: "10文字以上で入力してください")
        }else{
            confirmSend()
        }
    }
    func confirmSend(){
        
        self.view.endEditing(true)//キーボード閉じる
        
        let alert: UIAlertController = UIAlertController(title: "コメントを送信しますか？", message: "", preferredStyle:  UIAlertControllerStyle.alert)
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
            //**************
            let com:String = self.textView.text!
            let pos:String = self.selectedName
            
            Alamofire.request("http://www3275ui.sakura.ne.jp/anabuki/05/post/pushcomment.php", method: .post, parameters: ["id":1, "comment": "\(com)","post_id": "\(pos)","name_id":"送信者"]).responseString(completionHandler: { response in
                print(response.value)
            })
            //***************
            
            self.done()
        })
        
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
            (action: UIAlertAction!) -> Void in
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func done(){
        
        let alert: UIAlertController = UIAlertController(title: "送信完了", message: selectedName + "さんを評価しました", preferredStyle:  UIAlertControllerStyle.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            
            (action: UIAlertAction!) -> Void in
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    func textViewErr(errContents: String){
        let alert: UIAlertController = UIAlertController(title: "入力エラー", message: errContents, preferredStyle:  UIAlertControllerStyle.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
        })
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}

