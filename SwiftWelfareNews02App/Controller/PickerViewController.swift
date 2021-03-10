//
//  PickerViewController.swift
//  SwiftWelfareNews02App
//
//  Created by 中塚富士雄 on 2021/02/09.
//

import UIKit

class PickerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

//    var pickerView = UIPickerView()
    var label = UILabel()
    
    @IBOutlet weak var pickerView: UIPickerView!
    //指定RSS一覧
    var dataNameList = ["厚生労働省","訪問看護と介護","小金井市","福祉医療機構"]
    var dataURLList = ["https://www.mhlw.go.jp/stf/news.rdf","https://www.ndl.go.jp/jp/data/sakuin/rss/000000097643.xml","https://www.city.koganei.lg.jp/rss_news.xml","https://www.wam.go.jp/gyoseiShiryou/new_rss"]

//    let dataNameList = ["東京都福祉保健局",]
//    let dataURLList = [""https://www.fukushihoken.metro.tokyo.lg.jp/rss_news.xml"]
    
    
    
    
    
    
    var nameString = String()
    var urlString = String()
//    🌟indexをInt型に指定
    var index = Int()
    
    var nameArray = [String]()
    var urlArray = [String]()
    
    var nameArray2 = [String]()
    var urlArray2 = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        pickerView.delegate = self
//        pickerView.dataSource = self
//
//
//
//        self.view.addSubview(pickerView)
//
//
    }
   
    //NavigationBarを消す
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
   
        
        if UserDefaults.standard.object(forKey: "nameArray") != nil || dataNameList.count < 4{
            
            dataNameList = UserDefaults.standard.object(forKey: "nameArray") as! [String]
            
        }
        if UserDefaults.standard.object(forKey: "urlArray") != nil || dataURLList.count < 4{
            
            dataURLList = UserDefaults.standard.object(forKey: "urlArray") as! [String]
            
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        self.view.addSubview(pickerView)

        
        
        
        
        
    }
    
    //UIPickerViewの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataNameList.count
    }
    
    //UIPickerViewの最初の表示
    func pickerView(_ pickerView:UIPickerView, titleForRow row: Int,forComponent component: Int) -> String? {
        
        return dataNameList[row]
    }
    //UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        label.text = dataNameList[row]
//        nameArray.append(dataNameList[row])
//        urlArray.append(dataURLList[row])
        index = row
    }
    
    @IBAction func selected(_ sender: Any) {
        
        if UserDefaults.standard.object(forKey: "nameArray") != nil{
            
            dataNameList = UserDefaults.standard.object(forKey: "nameArray") as! [String]
            
        }
        if UserDefaults.standard.object(forKey: "urlArray") != nil{
            
            dataURLList = UserDefaults.standard.object(forKey: "urlArray") as! [String]
            
        }
        
        if UserDefaults.standard.object(forKey: "nameArray2") != nil{
            
            nameArray = UserDefaults.standard.object(forKey: "nameArray2") as! [String]
            
        }
        if UserDefaults.standard.object(forKey: "urlArray2") != nil{
            
            urlArray = UserDefaults.standard.object(forKey: "urlArray2") as! [String]
            
        }
//        nameArray = nameArray + nameArray2
//        urlArray = urlArray + urlArray2
        
        //選択されたもの
        urlArray.append(dataURLList[index])
        nameArray.append(dataNameList[index])
        UserDefaults.standard.setValue(urlArray, forKey: "urlArray2")
        UserDefaults.standard.setValue(nameArray, forKey: "nameArray2")
        
//        //🌟選択済みの要素を削除
        dataNameList.remove(at: index)
        dataURLList.remove(at: index)

//        
//        // Int型の配列をNSOrderedSetに変換
//        let orderedSet: NSOrderedSet = NSOrderedSet(array:nameArray)
//        // 再度Arrayに戻す
//        nameArray = orderedSet.array as! [String]
//        
//        // Int型の配列をNSOrderedSetに変換
//        let orderedSet2: NSOrderedSet = NSOrderedSet(array:urlArray)
//        // 再度Arrayに戻す
//        urlArray = orderedSet2.array as! [String]
//        
 
        UserDefaults.standard.setValue(urlArray, forKey: "urlArray")
        UserDefaults.standard.setValue(nameArray, forKey: "nameArray")

        
    }
    
    @IBAction func moveToNextWithData(_ sender: Any) {
        
        let nextVC = self.storyboard?.instantiateViewController(identifier: "nextVC") as! InfoDeckViewController
        
        self.navigationController?.pushViewController(nextVC, animated: true)
   
        
        
    }
    
    
    
    
}
