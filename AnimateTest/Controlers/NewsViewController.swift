//
//  NewsViewController.swift
//  AnimateTest
//
//  Created by Roman Efimov on 29/10/2019.
//  Copyright © 2019 Roman Efimov. All rights reserved.
//

import UIKit
import SDWebImage

class NewsViewController: UIViewController, UIScrollViewDelegate {
    let networkPlayersFetcher = NetworkPlayersFetcher()

    @IBOutlet weak var newsTableView: UITableView!
    var newsResponse: [News]? = nil
    
    var photo = UIImage()
    var previewPhotos = [UIImage()]
    var height: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.dataSource = self
        newsTableView.delegate = self
    
        fetchNews()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.title = "Новости"
        if #available(iOS 11, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        }
    }
    
    
    
    func fetchNews(){
        let networkNewsFetcher = NetworkNewsFetcher()
        networkNewsFetcher.fetchNews { (newsResponse) in
            guard let newsResponse = newsResponse else { return }
            self.newsResponse = newsResponse
            
            DispatchQueue.main.async() {
                self.newsTableView.reloadData()
            }
       }
    }
          
}




extension NewsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsFeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsFeedTableViewCell
        cell.scrollView.subviews.forEach { $0.removeFromSuperview() }
        cell.newsLabel.text = newsResponse?[indexPath.row].text ?? ""
        cell.newsLabel.numberOfLines = 0
        cell.newsLabel.frame = CGRect(x: 5, y: 0.0, width: cell.frame.width-5, height: 100)
        
        let photosCount = newsResponse?[indexPath.row].photosURL.count ?? 0
        
        for i in 0..<photosCount {
            
            print (newsResponse?[indexPath.row].photosURL[i])
            if let urlstring = newsResponse?[indexPath.row].photosURL[i] {
                if let photoUrl = URL(string: urlstring){
                    let imageView = UIImageView()
                    imageView.contentMode = .scaleAspectFit
                    imageView.sd_setImage(with: photoUrl)
                    
                    let xPos = CGFloat(i)*cell.bounds.size.width
                    
                    guard let photoWidth = newsResponse?[indexPath.row].width[0] else { return cell}
                    guard let photoHeight = newsResponse?[indexPath.row].height[0] else { return cell}
                    
                    var multiplier: CGFloat = 1
                    multiplier = CGFloat(photoWidth)/CGFloat(photoHeight)
                    cell.scrollView.frame = CGRect(x: 0.0, y: 110, width: view.frame.size.width, height: view.frame.size.width/multiplier)
                    imageView.frame = CGRect(x: xPos, y: 0, width: view.frame.size.width, height: view.frame.size.width/multiplier)
                    height = (cell.scrollView.frame.width/multiplier)+120
                    
                    cell.scrollView.contentSize.width = imageView.frame.size.width*CGFloat(i+1)
                    cell.scrollView.addSubview(imageView)
                    
                    cell.pageController.numberOfPages = photosCount
                    
                    if photosCount == 1{
                        cell.pageController.isHidden = true
                    } else {
                        cell.pageController.isHidden = false
                    }
                    cell.pageController.frame = CGRect(x: cell.frame.width/2-cell.pageController.frame.width/2, y: height-70, width: cell.frame.width, height: 100)
                    
                }
            }
            else {
                height = 120
                cell.scrollView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            }
        }

    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height
    }
    
    
    
}
