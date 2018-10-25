//
//  SuggestedCell.swift
//  WorldInHand
//
//  Created by Wmotion Mac 101 on 10/25/18.
//  Copyright © 2018 Azmi Muhammad Co. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SuggestedCell: UICollectionViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    var news: News? {
        didSet {
            if let berita = news {
                self.newsTitle.text = berita.title
                Alamofire.request(berita.urlToImage).responseImage { (response) in
                    switch response.result{
                    case .success:
                        if let image = response.result.value {
                            self.newsImage.image = image
                        }
                    case .failure(_):
                        break
                    }
                }
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
