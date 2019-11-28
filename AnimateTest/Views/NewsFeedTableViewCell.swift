//
//  NewsFeedTableViewCell.swift
//  AnimateTest
//
//  Created by Roman Efimov on 30/10/2019.
//  Copyright © 2019 Roman Efimov. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet weak var newsLabel: UILabel!
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

  
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/scrollView.frame.width
        pageController.currentPage = Int(page)
    }
    
    
   

}
