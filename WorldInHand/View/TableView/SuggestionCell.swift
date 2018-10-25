//
//  SuggestionCell.swift
//  WorldInHand
//
//  Created by Wmotion Mac 101 on 10/25/18.
//  Copyright © 2018 Azmi Muhammad Co. All rights reserved.
//

import UIKit

class SuggestionCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var news: [News]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SuggestedCell", bundle: nil), forCellWithReuseIdentifier: "SuggestedCell")
        collectionView.reloadData()
    }
    
}

extension SuggestionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.news?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedCell", for: indexPath) as? SuggestedCell,
            let berita = self.news {
            cell.news = berita[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
