//
//  MenuViewController.swift
//  LoginScreen
//

import UIKit
import Alamofire

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var storeData = StoreViewModel()
    
    var arrMenuItems = [String]()
    var response: [StoreModel]?
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        tapCloseMenu()
    }
    
    @objc  func tapCloseMenu()  {
        
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
        self.dismiss(animated: false, completion: nil)
    }
     

}

extension MenuViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 175
        }
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return arrMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            cell?.textLabel?.text = arrMenuItems[indexPath.row]
//            cell?.backgroundColor = UIColor(red: 230.0, green: 206.0, blue: 206.0, alpha: 1.0)
             return cell!
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "header")
        cell?.textLabel?.text = "Hi pamila"
        cell?.imageView?.image = UIImage.init(named: "place")
//        cell?.backgroundColor = UIColor(red: 230.0, green: 206.0, blue: 206.0, alpha: 1.0)
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tapCloseMenu()
    }
}
