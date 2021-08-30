//
//  HomeViewController.swift
//  LoginScreen
//
//  Created by Admin on 18/08/21.
//

import UIKit
import Alamofire
import AlamofireImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var storeData: StoreViewModel = StoreViewModel()
    
    var homeMenu = [String] ()
  //  let homeMenu = StoreViewModel.fetchStoreData(<#T##self: StoreViewModel##StoreViewModel#>)
     let tableList = ["MEN","WOMEN","ALL"]
 
    var response: [StoreModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Home"
        storeData.getCategories { Data in
            if let storeData = Data{
                self.homeMenu = storeData.map { $0 }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        storeData.fetchStoreData(category: "") { status, data in
            self.response = data!
            DispatchQueue.main.async {
                self.tableView.reloadData()

            }
        }
       
        setUpCollectionView()
        setUpMenu()
    }
    
    
    func setUpMenu() {
        let leftMenu = UIBarButtonItem.init(title: "Menu", style: UIBarButtonItem.Style.done, target: self, action: #selector(tapLeftMenu))
        self.navigationItem.setLeftBarButton(leftMenu, animated: false);
        
        let logoutMenu = UIBarButtonItem.init(title: "Logout", style: UIBarButtonItem.Style.done, target: self, action: #selector(logout))
        self.navigationItem.setRightBarButton(logoutMenu, animated: false);
    }
    
    func setUpCollectionView() {
        
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 150.0, height: 150.0)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        collectionView!.collectionViewLayout = layout
        
    }
    
    //MARK: - Actions
   
    
    @IBAction func tapLogout(_ sender: Any) {
        self.logout()
    }
    
    @objc func logout()  {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
        // (UIApplication.shared.connectedScenes.first?.delegate as?
           // SceneDelegate)?.changeRootViewController(viewController)
        
    }
    
    @objc func tapLeftMenu() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuViewController = storyboard.instantiateViewController(identifier: "MenuViewController") as! MenuViewController
        menuViewController.arrMenuItems = homeMenu
        
        menuViewController.modalPresentationStyle = .overCurrentContext
        
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(menuViewController, animated: false, completion: nil)
    }
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return homeMenu.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HomeMenuCollectionViewCell",
            for: indexPath) as! HomeMenuCollectionViewCell
        cell.lblTitle.text = homeMenu[indexPath.item]
        cell.imageView.image = UIImage(named: "place")
        
//        cell.backgroundColor = UIColor.systemPink
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        storeData.fetchStoreData(category: homeMenu[indexPath.item]) { status, data in
            self.response = data!
            DispatchQueue.main.async {
                self.tableView.reloadData()

            }
        }
       
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 248.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let res = response {
            return res.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        let product = response?[indexPath.row]
        cell.title.text = product?.title
        cell.desc.text = product?.welcomeDescription
    
        let placeholder = UIImage(named: "demo1")
        if let price = product?.price{
            
        cell.lblPrice.text = "Rs. \(price)"
        }
        if let imgURL = product?.image {
            let url = URL(string: imgURL)
            let filter = AspectScaledToFillSizeFilter(size: CGSize(width: 130.0, height: 200.0))
            cell.img.af.setImage(withURL: url!, placeholderImage: placeholder, filter: filter)
            
        }
        return cell
    }
    
}
