//
//  PageTableViewController.swift
//  SwiftWelfareNews02App
//
//  Created by 中塚富士雄 on 2021/02/09.
//

import UIKit
import SegementSlide

class PageTableViewController: UITableViewController,SegementSlideContentScrollViewDelegate,XMLParserDelegate {
    
    
    //XML Parserのインスタンスを作成する
    var parser = XMLParser()
   
    //RSSのパース中の現在の要素名
    var currentElementName:String!
    
    var newsItems = [NewsItems]()

    var index = Int()
    
    var urlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .clear
        
        switch index {
        case index:
        
        if UserDefaults.standard.object(forKey: "urlArray2") != nil{
            
            urlArray = UserDefaults.standard.object(forKey: "urlArray") as! [String]
    }
        //XMLパース
        //XMLパース(主要ニュース)
        print("A")
        print(urlArray.debugDescription)
//        for i in 0...urlArray.count - 1{
        
        //
        let urlString = urlArray[index]
 
        let url:URL = URL(string:urlString)!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        
        default:
            break
        }
    }
     @objc  var scrollView: UIScrollView{
        
        return tableView
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsItems.count }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/5
    }
    
    
    
    
    //日付は表示できるか？
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.backgroundColor = .clear
        
        let newsItem = self.newsItems[indexPath.row]
        
        cell.textLabel?.text = newsItem.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 3
        
        cell.detailTextLabel?.text = newsItem.url
        cell.detailTextLabel?.textColor = .white
        
        //⭐️日時が表示されてurlは表示されなくなる
        cell.detailTextLabel?.text = newsItem.pubDate
        cell.detailTextLabel?.textColor = .white
        
        
        return cell
    }
   
    
    //XML書式で書かれたものを一つ一つチェックしていく。"item"にぶつかったらNewsItems(modelで定義)を初期化する。
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElementName = nil
        if elementName == "item"{
            
            self.newsItems.append(NewsItems())
            
        
        }else{
                
                currentElementName = elementName
            
            
        }
            

    
    }
   
    //判定メソッド
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.newsItems.count > 0{
            
            //配列の中身は1→5だが、順番は0→4番目なので1を入れると1番目の2になってしまう
            let lastItem = self.newsItems[self.newsItems.count - 1]
            
        
            switch self.currentElementName {
            
            
            //stringはfoundCharactersで見つけたもの。それをlastItemのtitleに入れる。
            case "title":
                lastItem.title = string
                
            case "link":
                lastItem.url = string
                
            case "pubDate":
                lastItem.pubDate = string
                
            default:break
                
            }
          
        }
    
    }
     
        func parser(_ parser:XMLParser, didEndElement elementName: String, namespaceURI: String? , qualifiedName qName: String?){
            
            self.currentElementName = nil
        }
          
            func parserDidEndDocument(_ parser: XMLParser){
                
                self.tableView.reloadData()
            }

               
            override func tableView(_ tableView: UITableView, didSelectRowAt IndexPath: IndexPath){
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let webVC = storyboard.instantiateViewController(withIdentifier: "webVC") as! WebViewController
                webVC.urlString = newsItems[IndexPath.row].url!
                self.present(webVC, animated: true, completion: nil)
                
                
                
                
                
                
                
//                  let pageTableViewController = PageTableViewController()
//                pageTableViewController.modalTransitionStyle = .crossDissolve
//                let newsItem = newsItems[IndexPath.row]
//                UserDefaults.standard.set(newsItem.url, forKey: "url")
//                present(pageTableViewController,animated: true, completion: nil)
                    
    }
}

