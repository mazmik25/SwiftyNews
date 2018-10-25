//
//  NewsCell.swift
//  WorldInHand
//
//  Created by Wmotion Mac 101 on 10/24/18.
//  Copyright © 2018 Azmi Muhammad Co. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var news: News? {
        didSet {
            if let berita = news {
                titleLabel.text = berita.title
                descriptionLabel.text = berita.description
                sourceLabel.text = berita.source + " - " + berita.author
                Alamofire.request(berita.urlToImage).responseImage { (response) in
                    switch response.result{
                    case .success:
                        if let image = response.result.value {
                            self.newsImageView.image = image
                        }
                    case .failure(_):
                        break
                    }
                }
                print(String.formatDate(fromString: berita.publishedAt))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

