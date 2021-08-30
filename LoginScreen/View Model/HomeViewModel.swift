//
//  StoreModel.swift
//  LoginScreen
//
//  Created by Admin on 29/08/21.
//

import Foundation
import ObjectMapper
import AlamofireImage
import Alamofire

class StoreViewModel {
    
    var StoreModel: [StoreViewModel]?
        
    let StoreDateUrl: String = "https://fakestoreapi.com/products"
//
//    
    func fetchStoreData(category: String, completionHandler: @escaping (_ status: Bool, _ response: [StoreModel]?) -> ()){
           var finalURL = ""
            if category.isEmpty {
                finalURL = StoreDateUrl
            }else
            {
                let escapedString: String = category.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
                finalURL = "https://fakestoreapi.com/products/category/\(escapedString)"
                print(finalURL)
            }
            

            guard let urlString = URL(string: finalURL) else { return }
            
            AF.request(urlString).responseJSON { (responce) in
                switch responce.result {
                case .success(let value):
                    guard let castingValue = value as? [[String: Any]] else { return }
                   let responseModel = Mapper<StoreModel>().mapArray(JSONArray: castingValue)
                    
                    completionHandler(true, responseModel)
                                 
                case .failure(let error):
                    completionHandler(false, nil)
                    print(error.localizedDescription)
                }
                
            }
        }
    
    func getCategories(completionHandler: @escaping (_ data: [String]?) -> ()) {
        
        let categoriesUrl = "https://fakestoreapi.com/products/categories"
        
        guard let urlString = URL(string: categoriesUrl) else { return }
        AF.request(urlString).responseJSON { (responce) in
            switch responce.result {
            case .success(let value):
                guard let castingValue = value as? [String] else { return }
                    print(castingValue)
                completionHandler(castingValue)
               
            case .failure(let error):
                completionHandler(nil)
                print(error.localizedDescription)
            }
        }
    }
   
}
