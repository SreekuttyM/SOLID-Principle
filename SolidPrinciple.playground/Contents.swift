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
