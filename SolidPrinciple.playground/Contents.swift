import UIKit

//MARK: - SINGLE RESPONSIBILITY PRINCIPLE

/*
 NOTES:
 A class should only be responsible for one thing
 */


struct Product {
    let price : Double
}

///sample violating the srp
struct Invoice {
    var products : [Product]
    let id = NSUUID().uuidString
    var discountPercentage : Double = 0.0
    
    var total : Double {
        let total = products.map({$0.price}).reduce(0, { $0 + $1 })
        let discountedAmount = total * (discountPercentage / 100)
        return total - discountedAmount
    }
    
    func printInvoice() {
        print("--------")
        print("Invoice id :\(id)")
        print("Total cost :\(total)")
        print("Discounts  :\(discountPercentage)")
        print("--------")
    }
    
    func saveInvoice() {
        //save invoice locally or to database
    }
}
