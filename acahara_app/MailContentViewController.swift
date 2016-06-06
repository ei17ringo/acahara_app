//
//  MailContentViewController.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/06/06.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class MailContentViewController: UIViewController, UITextViewDelegate{
    
 

    @IBOutlet weak var personType: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mailTextView: UITextView!
    //起動画面サイズの取得
    let myBoundsize:CGSize = UIScreen.mainScreen().bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        var myDefault = NSUserDefaults.standardUserDefaults()
        
        var pType = myDefault.stringForKey("personType")
        
        if( pType != nil){
            print(pType)
            personType.text = "("+pType!+")"
        
            mailTextView.delegate = self
            
            //最初からカーソルが反転してキーボードが表示される処理
            mailTextView.becomeFirstResponder()
            
            //履歴全件削除の設定 1回使ったらコメントアウト
            //        var myDefault = NSUserDefaults.standardUserDefaults()
            //
            //        var appDomain:String = NSBundle.mainBundle().bundleIdentifier!
            //                myDefault.removePersistentDomainForName(appDomain)
            
            //決定ボタンのついたラベルをキーボードの上に設置
            var accessoryView = UIView(frame: CGRectMake(0, 178, 320, 30))
            
            accessoryView.backgroundColor = UIColor.lightGrayColor()
            
            
            
            var closeButton = UIButton(frame: CGRectMake(myBoundsize.width-50, 5, 40, 20))
            
            
            closeButton.setTitle("決定", forState: UIControlState.Normal)
            //決定のフォントサイズを小さくする
            closeButton.titleLabel?.font = UIFont.systemFontOfSize(15)
            closeButton.setTitleColor(UIColor.whiteColor(),
                                      forState: UIControlState.Normal)
            closeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
            closeButton.addTarget(self, action: "onClickCloseButton:", forControlEvents: .TouchUpInside)
            accessoryView.addSubview(closeButton)
            
            
            mailTextView.inputAccessoryView = accessoryView
        
        
        }
    }
    
    func onClickCloseButton(sender: UIButton) {
        
        mailTextView.resignFirstResponder()
        
        mailTextView.frame = CGRectMake(10, 20, 310, 480)
        
        //UITextViewの先頭にカーソルを合わせる
        mailTextView.selectedRange = NSMakeRange(0,0)
        
       // mailTextView.frame = CGRectMake(0, 20, 320, 700)
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        var myDefault = NSUserDefaults.standardUserDefaults()
        var mailContent = myDefault.stringForKey("selectedText")
        
        if( mailContent != nil){
            //print(diary)
            
            mailTextView.text = mailContent
        }
        
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
                let offsetY: CGFloat = CGRectGetMaxY(mailTextView.frame) - CGRectGetMinY(convertedKeyboardFrame)
                if offsetY < 0 { return }
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
        
        var mailText = mailTextView.text
        
        //if ((diaryText != nil) && (diaryText != "")){
        //ユーザーデフォルトを用意する
        var myDefault = NSUserDefaults.standardUserDefaults()
        //データを書き込んで
        myDefault.setObject(mailText, forKey: "mailContent")
        
        //即反映させる
        myDefault.synchronize()
        
        mailTextView.resignFirstResponder()
        
        self.dismissViewControllerAnimated(true, completion: nil)
        //}
        
    }
    
    
    
    @IBAction func cancelBtn(sender: UIButton) {
        
        mailTextView.resignFirstResponder()
        
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