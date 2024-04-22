import UIKit

//MARK: - SINGLE RESPONSIBILITY PRINCIPLE

/*
 NOTES:
 A class should only be responsible for one thing
 */


struct Product {
    let price : Double
}

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
        let printInvoice = InvoicePrinter(invoice: self)
        printInvoice.printInvoice()
    }
    
    func saveInvoice() {
        //save invoice locally or to database
        let printInvoice = InvoicePersistance(invoice: self)
        printInvoice.saveInvoice()
    }
}

struct InvoicePrinter {
    let invoice : Invoice
    
    func printInvoice() {
        print("--------")
        print("Invoice id :\(invoice.id)")
        print("Total cost :\(invoice.total)")
        print("Discounts  :\(invoice.discountPercentage)")
        print("--------")
    }
}

struct InvoicePersistance {
    let invoice : Invoice

    func saveInvoice() {
        //save invoice locally or to database
    }
}

let products = [Product.init(price: 120),Product.init(price: 140),Product.init(price: 130)]

let invoice1 = Invoice(products: products, discountPercentage: 20)
let invoice2 = Invoice(products: products)


//MARK: - OPEN CLOSED PRINCIPLE (OCP)

/*
 NOTES:
  Software entities(classes,modules,functions etc..) should be open for extension but closed for modification.
  In other words, we can add additional functionality (extension) without modifyting the existing behaviour (modification) of the object.
 */
//eg with swift provided extensions

extension Int {
    func squared() -> Int {
        return self * self
    }
}

var num : Int = 2
print(num.squared())

//another practical exmaple

// here new features are extendable with the usage of protocol
//we can create new struct to define new funcationalitites to save data
struct InvoiceOCP {
    let persistance : InvoicePersistable
    
    func save(invoice:Invoice) {
        persistance.save(invoice: invoice)
    }
    
//    func saveToDB() {
//        //save invoice locally or to database
//        print("save to FireBase\(invoice.id)")
//    }
//    
//    func saveToCoreData() {
//        //save invoice locally or to database
//        print("save to CoreData\(invoice.id)")
//
//    }
}

protocol InvoicePersistable {
    func save(invoice:Invoice)
}

struct CoreDataPersistence : InvoicePersistable {
    func save(invoice: Invoice) {
        print("save to CoreData\(invoice.id)")
    }
}

struct DBPersistence : InvoicePersistable {
    func save(invoice: Invoice) {
        print("save to FireBase\(invoice.id)")
    }
}

// Note: This example  is a combination of OCP and SRP

//MARK: - Liskov Substitution Principle
/*
 Notes:
    Derived or child classes/structures must be substitutable for their base or parent class
 */

//eg

enum APIError : Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode
}

struct MockUserService {
    func fetchUser() async throws {
        do {
            throw APIError.invalidResponse
        } catch {
            print("Error:\(error)")
        }
    }
}



//MARK: - Interface Segregation Principle
/*
 Notes:
    Do not force the client to implement an interface which is irrevelant to them
 */

//eg


protocol SingleTapProtocol {
    func didTap()
}

protocol DoubleTapProtocol {
    func didDoubleTap()
}

protocol LongPressProtocol {
    func didLonPress()
}

struct SuperButton : SingleTapProtocol,DoubleTapProtocol,LongPressProtocol {
    func didTap() {}
    func didDoubleTap() {}
    func didLonPress() {}
}

struct SingleTapButton : SingleTapProtocol {
    func didTap() {}
    func didDoubleTap() {}
    func didLonPress() {}
}

