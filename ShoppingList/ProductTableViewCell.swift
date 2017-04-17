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
    @IBOutlet weak var button: UIButton!
    
    var buttonAction: ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        button.layer.cornerRadius = 3.0
    }
    
    func configureCell(item: StockItem) {
        title.text = item.product.title
        price.text = "\(item.product.price)$"
        stockAmount.text = String(item.quantity)
    }
    
    func configureCell(cart item: CartItem) {
        title.text = item.product.title
        price.text = "\(item.product.price)$"
        stockAmount.text = String(item.quantity)
    }
    
    @IBAction func buttonTap(sender: AnyObject) {
        buttonAction?(self)
    }
    
}
