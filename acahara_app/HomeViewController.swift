//
//  FirstViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/05/26.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var homeTableView: UITableView!

  
    // ボタンを用意
    var addBtn: UIBarButtonItem!
    
    var posts:[NSDictionary] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableView.registerNib(UINib(nibName: "postCustomCell", bundle: nil), forCellReuseIdentifier: "postCustomCell")
        
        // タイトルを付けておきましょう
        self.title = "Home"
        
        // addBtnを設置
        addBtn = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: "onClick")
        self.navigationItem.rightBarButtonItem = addBtn

    }
    
    override func viewWillAppear(animated: Bool) {
        let path = NSBundle.mainBundle().pathForResource("posts", ofType: "txt")
        let jsondata = NSData(contentsOfFile: path!)
        
        let jsonArray = (try! NSJSONSerialization.JSONObjectWithData(jsondata!, options: [])) as! NSArray
        
        for data in jsonArray{
            posts.append(data as! NSDictionary)
        }
    }
    
    //行数決定
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    //表示内容を決定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell{
            
        // 1. 生成するセルをカスタムクラスへダウンキャスト
        // 既存のCell生成コードの後に as! <Cellのカスタムクラス名> という記述を追加
        var cell = tableView.dequeueReusableCellWithIdentifier("postCustomCell", forIndexPath: indexPath) as! homeTableViewCell
        cell.postCreated.text = posts[indexPath.row]["created"] as! String
        cell.postWhen.text = posts[indexPath.row]["when"] as! String
        cell.postWhere.text = posts[indexPath.row]["where"] as! String
        cell.postWho.text = posts[indexPath.row]["who"] as! String
        cell.postUniversity.text = posts[indexPath.row]["university"] as! String
        cell.postDiary.text = posts[indexPath.row]["diary"] as! String
        cell.postImageView.image = UIImage(named:(posts[indexPath.row]["picture"] as! String))
        
        
        //postsのopenFlag==1のセルだけ下のようにしたい
        cell.backgroundColor = UIColor.groupTableViewBackgroundColor()
        cell.postDiary.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        
        return cell
    }
    
    func tappedSettingBtn(){
        var settingController = UIAlertController(title: "この投稿を変更する", message: "削除？変更？", preferredStyle: .ActionSheet)
        settingController.addAction(UIAlertAction(title: "削除", style: .Default, handler: { action in print("OK!")}))
        
        settingController.addAction(UIAlertAction(title: "モード変更", style: .Default, handler: { action in print("OK!")}))
        
        
        settingController.addAction(UIAlertAction(title: "キャンセル", style: .Cancel, handler: { action in
            print("cancel")
        }))
        
        
        presentViewController(settingController, animated: true, completion: nil)
    }

    


    
    // addBtnをタップしたときのアクション
    func onClick() {
        
        let second = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddViewController") as UIViewController
        
        self.navigationController?.pushViewController(second, animated: true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

