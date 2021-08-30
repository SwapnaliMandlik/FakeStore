

import Foundation
import ObjectMapper

// MARK: - WelcomeElement
struct StoreModel: Mappable {
    
    var id: Int?
    var title: String?
    var price: Double?
    var welcomeDescription: String?
    var category: String?
    var image: String?
    var rating : Rating?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        price <- map["price"]
         welcomeDescription <- map["welcomeDescription"]
         category <- map["category"]
         image <- map["image"]

    }
  
}


struct Rating : Mappable {
    var rate : Double?
    var count : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        rate <- map["rate"]
        count <- map["count"]
    }
    
}

