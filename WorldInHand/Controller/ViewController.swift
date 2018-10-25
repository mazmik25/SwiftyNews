//
//  ViewController.swift
//  WorldInHand
//
//  Created by Wmotion Mac 101 on 10/24/18.
//  Copyright © 2018 Azmi Muhammad Co. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var news: [News]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.news = [News]()
        self.getData()
    }
    
    func getData() {
        self.news?.removeAll()
        let url = Base.newsUrl + "top-headlines"
        let category = Base.categories[Int.random(in: 0...5)]
        let params: [String : Any] = [NewsParameter.q : category, NewsParameter.token : Base.newsToken, NewsParameter.pageSize : 20]
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                for article in json["articles"].arrayValue {
                    let news = News(json: article)
                    self.news?.append(news)
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
        self.tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
    }
    
    @IBAction func refreshItem(_ sender: Any) {
        self.getData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell {
            cell.news = self.news?[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let berita = self.news else { return }
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailVC") as? NewsDetailVC else { return }
        vc.news = berita[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
