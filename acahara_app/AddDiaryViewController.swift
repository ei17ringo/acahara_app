//
//  AddDiaryViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/05/29.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary
import Photos
import AVFoundation




class AddDiaryViewController: UIViewController, UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var header: UIView!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var diaryTextView: UITextView!
    @IBOutlet weak var cancelBtn: UIButton!

    @IBOutlet weak var saveBtn: UIImageView!

    
    //起動画面サイズの取得
    let myBoundsize:CGSize = UIScreen.mainScreen().bounds.size

    override func viewDidLoad() {
        super.viewDidLoad()
        
        diaryTextView.delegate = self
        
        
        
        //最初からカーソルが反転してキーボードが表示される処理
        diaryTextView.becomeFirstResponder()
        
       //行間の設定 ここで大きさがリセットされているから、リセット後にサイズを指定しないといけない
        
        
       

        
//履歴全件削除の設定 1回使ったらコメントアウト
//        var myDefault = NSUserDefaults.standardUserDefaults()
//        
//        var appDomain:String = NSBundle.mainBundle().bundleIdentifier!
//                myDefault.removePersistentDomainForName(appDomain)
        
        //決定ボタンや写真、動画を選択するイメージのついたラベルをキーボードの上に設置
        var accessoryView = UIView(frame: CGRectMake(0, 178, 320, 40))
        
        accessoryView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        
        
        var closeCoverButton = UIButton(frame: CGRectMake(myBoundsize.width-40, 8, 25, 25))
        
        var closeImage = UIImageView(frame: CGRectMake(myBoundsize.width-40, 8, 25, 25))
        
        var photoImage = UIImageView(frame: CGRectMake(20, 8, 25, 25))
        
        var photoCoverBtn = UIButton(frame: CGRectMake(20,8,25,25))
        
        
        
        var filmImage = UIImageView(frame: CGRectMake(75,8,25,25))
        
        var filmCoverBtn = UIButton(frame: CGRectMake(75,8,25,25))
       

        
        
        
        
        photoImage.image = UIImage(named:"photoImage")?.imageWithRenderingMode(.AlwaysTemplate)
        
        let sakura2:UIColor = UIColor(red:1.0,green:0.3,blue:0.3,alpha:1.0)
        
        photoImage.tintColor = sakura2
        
        
        filmImage.image = UIImage(named:"film")?.imageWithRenderingMode(.AlwaysTemplate)
        
       
        filmImage.tintColor = sakura2
        
        
        
        closeImage.image = UIImage(named:"arrowDown")?.imageWithRenderingMode(.AlwaysTemplate)
  
        closeImage.tintColor = sakura2
        

        
        closeCoverButton.addTarget(self, action: "onClickCloseButton:", forControlEvents: .TouchUpInside)
        photoCoverBtn.addTarget(self, action: "onClickPhotoButton:", forControlEvents: .TouchUpInside)
        filmCoverBtn.addTarget(self, action: "onClickFilmButton:", forControlEvents: .TouchUpInside)
        

        
        accessoryView.addSubview(closeImage)
        accessoryView.addSubview(closeCoverButton)
        accessoryView.addSubview(photoImage)
        accessoryView.addSubview(photoCoverBtn)
        accessoryView.addSubview(filmImage)
        accessoryView.addSubview(filmCoverBtn)
        

        diaryTextView.inputAccessoryView = accessoryView
        

        
//        let inbox = FAKFontAwesome.inboxIconWithSize(25)
//        
//        let sakura:UIColor = UIColor(red:1.0,green:0.4,blue:0.4,alpha:1.0)
//        
//        inbox.addAttribute(NSForegroundColorAttributeName, value: sakura)
//
//        
//        let boxImage = inbox.imageWithSize(CGSizeMake(25, 25))
//        
//        saveBtn.setImage(boxImage, forState: .Normal)
        
        //保存ボタンのイメージを設置して色変更
        saveBtn.image = UIImage(named:"check")?.imageWithRenderingMode(.AlwaysTemplate)
        
        let sakura:UIColor = UIColor(red:1.0,green:0.3,blue:0.3,alpha:1.0)
        saveBtn.tintColor = sakura

        
        
        
    }
    
    
    //キーボードの上にあるバーの下矢印アイコンをタップしたらキーボードを下げ、全文表示する処理
    func onClickCloseButton(sender: UIButton) {
        diaryTextView.resignFirstResponder()
        
        //Mark:ここを修正 記入時とフレームの位置を合わせる、カクンとさせない
        //diaryTextView.frame = CGRectMake(0, 20, 320, 700)
        diaryTextView.frame = CGRectMake(10,20, diaryTextView.bounds.width,myBoundsize.height-85)
        
    }
    
    //photoCoverBtnがタップされた時、写真を選択できる一覧を表示
    func onClickPhotoButton(sender: UIButton){
        
        
        var photoPick = UIImagePickerController()
            
            photoPick.delegate = self
            
            photoPick.sourceType = .PhotoLibrary
            self.presentViewController(photoPick, animated: true, completion: nil)
        }
    
    //movieCoverBtnがタップされた時、動画を選択できる一覧を表示
    func onClickFilmButton(sender: UIButton){
        
        var movPick = UIImagePickerController()
                movPick.delegate = self
                movPick.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                movPick.mediaTypes = [kUTTypeMovie as String]
                movPick.allowsEditing = false
                movPick.delegate = self
                self.presentViewController(movPick, animated: true, completion: nil)
        
        
    }
    
    //写真や画像をリストから選択した時の処理。ユーザーデフォルトに選択したデータへのパスをセット
    func imagePickerController(imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            
            
            
        // ユーザーデフォルトを用意する
        var myDefault = NSUserDefaults.standardUserDefaults()
            
            
        let strTypeMovie:String = kUTTypeMovie as! String
            
            if info[UIImagePickerControllerMediaType] as! String == strTypeMovie{
                //動画
                var url:NSURL = info[UIImagePickerControllerMediaURL] as! NSURL
                
                var strURL:String = url.description//こうすると文字列型に変換できる
                
                
                
                // データを書き込んで
                myDefault.setObject(strURL, forKey: "selectedMovieURL")
                
                
                
                
            }else{
                let assetURL:AnyObject = info[UIImagePickerControllerReferenceURL]!
                
                var strURL:String = assetURL.description
                
                
                // データを書き込んで
                myDefault.setObject(strURL, forKey: "selectedPhotoURL")
                
            }
            // 即反映させる
            myDefault.synchronize()
            //　選択画面を落とす
            self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    

    //TODO:こちらでは空のファイルイメージだけバーの上の方に置く
 
    
    
    override func viewWillAppear(animated: Bool) {
        
        var myDefault = NSUserDefaults.standardUserDefaults()
        var diary = myDefault.stringForKey("diary")
        
        if( diary != nil){
            print(diary)
            diaryTextView.text = diary
            
            //フォントサイズの指定
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 6
            let attributes = [NSParagraphStyleAttributeName : style]
            diaryTextView.attributedText = NSAttributedString(string: diaryTextView.text,
                                                              attributes: attributes)
            diaryTextView.font = UIFont.systemFontOfSize(17)
            
            //MARK:先頭にカーソルを合わせる
            diaryTextView.selectedRange = NSMakeRange(0, 0)
            
        }else{
            //何も記載されてない場合
            
        
            diaryTextView.text = "test\ntest2"
            
            //フォントサイズの指定
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 6
            let attributes = [NSParagraphStyleAttributeName : style]
            diaryTextView.attributedText = NSAttributedString(string: diaryTextView.text,
                                                              attributes: attributes)
            diaryTextView.font = UIFont.systemFontOfSize(17)
            
            diaryTextView.text = ""
        }
        
        
        //キーボードがテキストに被らないようにする下処理、キーボードの動きを感知？
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "keyboardWillBeShown:",
                                                         name: UIKeyboardWillShowNotification,
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "keyboardWillBeHidden:",
                                                         name: UIKeyboardWillHideNotification,
                                                         object: nil)

        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        //キーボードがテキストに被らないようにする処理
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIKeyboardWillShowNotification,
                                                            object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIKeyboardWillHideNotification,
                                                            object: nil)
    }

    func keyboardWillBeShown(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue, animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue {
                restoreScrollViewSize()
                
                let convertedKeyboardFrame = scrollView.convertRect(keyboardFrame, fromView: nil)
                var offsetY: CGFloat = CGRectGetMaxY(diaryTextView.frame) - CGRectGetMinY(convertedKeyboardFrame)
                
                //MARK:追加
                diaryTextView.frame = CGRectMake(18,20, diaryTextView.bounds.width, myBoundsize.height - convertedKeyboardFrame.height-65)
                
                
                
                
                if offsetY < 0 { return }
                //Mark:計算結果を使わずにここで決め打ちしてしまう方が安定
                offsetY = 10.0
                
                
                updateScrollViewSize(offsetY, duration: animationDuration)
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        restoreScrollViewSize()
    }

    // MARK: - UITextFieldDelegate//ここがリターンじゃなくボタンの設定も？//ここが効かない,テキストフィールドなので　doneボタンを付ける
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
    
    func updateScrollViewSize(moveSize: CGFloat, duration: NSTimeInterval) {
        UIView.beginAnimations("ResizeForKeyboard", context: nil)
        UIView.setAnimationDuration(duration)
        
        let contentInsets = UIEdgeInsetsMake(0, 0, moveSize, 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        scrollView.contentOffset = CGPointMake(0, moveSize)
        
        UIView.commitAnimations()
    }
    
    func restoreScrollViewSize() {
        scrollView.contentInset = UIEdgeInsetsZero
        scrollView.scrollIndicatorInsets = UIEdgeInsetsZero
    }


    @IBAction func saveBtn(sender: UIButton) {
        
        var diaryText = diaryTextView.text
    
        //if ((diaryText != nil) && (diaryText != "")){
            //ユーザーデフォルトを用意する
            var myDefault = NSUserDefaults.standardUserDefaults()
            //データを書き込んで
            myDefault.setObject(diaryText, forKey: "diary")
            
            //即反映させる
            myDefault.synchronize()
        
        diaryTextView.resignFirstResponder()
            
        self.dismissViewControllerAnimated(true, completion: nil)
        //}
        
    }
    
    
    
    @IBAction func cancelBtn(sender: UIButton) {
        
        diaryTextView.resignFirstResponder()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
