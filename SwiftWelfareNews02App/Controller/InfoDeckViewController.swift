//
//  InfoDeckViewController.swift
//  SwiftWelfareNews02App
//  🌟BaseViewControllerに相当
//  Created by 中塚富士雄 on 2021/02/09.
//

import UIKit
import SegementSlide

class InfoDeckViewController: SegementSlideDefaultViewController {

    var nameArray = [String]()
    var urlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    if UserDefaults.standard.object(forKey: "nameArray") != nil{
            
    nameArray = UserDefaults.standard.object(forKey: "nameArray") as! [String]
    
    
    }
        //画像をTableViewの下に置く
        let image = UIImage(named: "header")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height:250))
    
            imageView.image = image
        self.view.addSubview(imageView)

        reloadData()
        defaultSelectedIndex = 0
        
    }

    //
    
    override func segementSlideHeaderView() -> UIView? {
            let headerView = UIView()
            headerView.translatesAutoresizingMaskIntoConstraints = false

        headerView.heightAnchor.constraint(equalToConstant: view.bounds.height/4).isActive = true
            return headerView
        
}
    override var titlesInSwitcher: [String] {

        return nameArray
        
    }
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        
        switch index {
        case nameArray.count - 1:
            
            let viewController: PageTableViewController = PageTableViewController()
            viewController.index = index
        
            return PageTableViewController()
            
        default:
            return PageTableViewController()
        }
    }

    //NavigationBarを消す
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
    }




}
