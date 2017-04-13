//
//  ProductTableViewCell.swift
//  ShoppingList
//
//  Created by Olya Lutsyk on 4/13/17.
//
//

import Foundation
import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var stockAmount: UILabel!
    
    var buyAction: ((UITableViewCell) -> Void)?
    
    func configureCell(item: StockItem) {
        title.text = item.product.title
        price.text = "\(item.product.price)$"
        stockAmount.text = String(item.quantity)
    }
    
    @IBAction func buttonTap(sender: AnyObject) {
        buyAction?(self)
    }
    
}
