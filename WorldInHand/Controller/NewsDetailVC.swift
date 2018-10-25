//
//  NewsDetailVC.swift
//  WorldInHand
//
//  Created by Wmotion Mac 101 on 10/25/18.
//  Copyright © 2018 Azmi Muhammad Co. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsDetailVC: UIViewController {

    var news: News?
    var data = [News]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        randomNews()
    }

    func randomNews() {
        let url = Base.newsUrl + "top-headlines"
        let category = Base.categories[Int.random(in: 0...5)]
        let params: [String : Any] = [NewsParameter.q : category, NewsParameter.token : Base.newsToken, NewsParameter.pageSize : 20]
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                for article in json["articles"].arrayValue {
                    let news = News(json: article)
                    self.data.append(news)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(UINib(nibName: "NewsHeaderCell", bundle: nil), forCellReuseIdentifier: "NewsHeaderCell")
        self.tableView.register(UINib(nibName: "SuggestionCell", bundle: nil), forCellReuseIdentifier: "SuggestionCell")
    }
}

extension NewsDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHeaderCell", for: indexPath) as? NewsHeaderCell, let berita = self.news {
                cell.news = berita
                return cell
            }
            
            return UITableViewCell()
        case 1:
            let cell = UITableViewCell()
            cell.textLabel?.text = self.news?.content ?? "Empty content"
            cell.textLabel?.numberOfLines = 0
            cell.isUserInteractionEnabled = false
            return cell
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath) as? SuggestionCell {
                cell.setupCollectionView()
                cell.news = self.data
                cell.collectionView.reloadData()
                return cell
            }
            
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
