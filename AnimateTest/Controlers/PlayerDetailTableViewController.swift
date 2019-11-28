//
//  PlayerDetailTableViewController.swift
//  AnimateTest
//
//  Created by Roman Efimov on 23/10/2019.
//  Copyright © 2019 Roman Efimov. All rights reserved.
//

import UIKit

class PlayerDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var photo: UIImageView!
    var playerInfo: [String] = []
    var photoURL: String = ""
    
    let networkPlayersFetcher = NetworkPlayersFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        activityView.frame = CGRect(x: photo.frame.width/2-50, y: photo.frame.height/2-50, width: 100, height: 100)
        self.photo.addSubview(activityView)
        activityView.startAnimating()
        
        let url = URL(string: photoURL)
        networkPlayersFetcher.fetchImage(url: url) { (image) in
            guard let image = image else {return}
            
            DispatchQueue.main.async {
                self.photo.image = image
                activityView.stopAnimating()
                
            }
        }
    }
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerInfo.count
        
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = playerInfo[indexPath.row]

        return cell
    }


}
