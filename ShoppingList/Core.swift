//
//  Models.swift
//  ShoppingList
//
//  Created by Olya Lutsyk on 4/13/17.
//
//

import Foundation

enum ShopError: Error {
    case noSuchProductInStock
    case notInCart
    case insufficientQuantity(inStock: Int)
}

struct Product: Equatable {
    let id: Int
    let title: String
    let price: Decimal
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}

struct StockItem {
    let product: Product
    var quantity: Int
}


struct CartItem {
    let product: Product
    var quantity: Int
    
    var price: Decimal {
        return product.price * Decimal(quantity)
    }
}

struct Cart {
    var items: [CartItem]
    
    var totalPrice: Decimal {
        return items.reduce(Decimal(0), { $0 + $1.price })
    }
    
    mutating func addProduct(product: Product, quantity: Int = 1) {
        if let idx = items.index(where: {$0.product == product }) {
            items[idx].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: quantity))
        }
    }
    
    mutating func removeFromCart(product: Product) throws -> CartItem {
        if let idx = items.index(where: { $0.product == product }) {
            return items.remove(at: idx)
        } else {
            throw ShopError.notInCart
        }
    }
    
    static func empty() -> Cart {
        return Cart(items: [])
    }
}


class Shop {
    var stock:[StockItem] = []
    var cart = Cart.empty()
    
    static var sharedShop:Shop = Shop()
    
    var availableItems : [StockItem] {
        return stock.filter({$0.quantity > 0})
    }
    
    func addToCart(product:Product, quantity requestedQty: Int = 1) throws {
        if let idx = stock.index(where: {$0.product == product}) {
            if(requestedQty <= stock[idx].quantity) {
                stock[idx].quantity -= requestedQty
                cart.addProduct(product: product, quantity: requestedQty)
            } else {
                throw ShopError.insufficientQuantity(inStock: stock[idx].quantity)
            }
        } else {
            throw ShopError.noSuchProductInStock
        }
    }
    
    func removeFromCart(product: Product) throws {
        let item = try cart.removeFromCart(product: product)
        if let idx = stock.index(where: {$0.product == product}) {
            stock[idx].quantity += item.quantity
        }
    }
}
