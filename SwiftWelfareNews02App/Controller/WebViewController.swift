//
//  WebViewController.swift
//  SwiftWelfareNews02App
//
//  Created by 中塚富士雄 on 2021/02/21.
//

import UIKit
import WebKit


class WebViewController: UIViewController{

    @IBOutlet weak var webView: WKWebView!
    var urlString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    let url = URL(string: urlString)
    let request = URLRequest(url: url!)
        webView.load(request)
 
    webView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 50)
        view.addSubview(webView)
        

    }
    


}
