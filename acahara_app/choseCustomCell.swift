//
//  homeTableViewCell.swift
//  acahara_app
//
//  Created by RIho OKubo on 2016/05/26.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit

class choseCustomCell: UITableViewCell {
    
    @IBOutlet weak var circle: UIImageView!
    
    @IBOutlet weak var postPortrait: UIImageView!
    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var postCreated: UILabel!
    @IBOutlet weak var postWhen: UILabel!
    @IBOutlet weak var postWhere: UILabel!
    @IBOutlet weak var postWho: UILabel!
    @IBOutlet weak var postUniversity: UILabel!
    @IBOutlet weak var postDiary: UITextView!

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postMoreBtn: UIButton!

    @IBOutlet weak var postTextViewBtn: UIButton!

    @IBOutlet weak var coverBtn: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        
        circle.image = UIImage(named:"circle")
        
        
        postPortrait.image = UIImage(named:"selfee.JPG")
//
//        let volume = FAKFontAwesome.volumeUpIconWithSize(18)
//        let volumeImage = volume.imageWithSize(CGSizeMake(18, 18))
//        postVolume.image = volumeImage

        

                               
    }


  


        

    
        
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
