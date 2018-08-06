import UIKit

class TabBar: UITabBarController{

    //最初からあるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        //レンダリングモードをAlwaysOriginalでボタンの画像を登録する。
        tabBar.items![0].image = UIImage(named: "users")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        tabBar.items![1].image = UIImage(named: "chat02")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        tabBar.items![2].image = UIImage(named: "time")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        tabBar.items![3].image = UIImage(named: "set")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        //選択中のアイテムの画像もレンダリングモード指定。
        tabBar.items![0].selectedImage = UIImage(named: "usersb")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        tabBar.items![1].selectedImage = UIImage(named: "chatb02")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        tabBar.items![2].selectedImage = UIImage(named: "timeb")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        tabBar.items![3].selectedImage = UIImage(named: "setb")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

    }
}

