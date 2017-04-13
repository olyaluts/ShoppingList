//
//  MasterViewController.swift
//  ShoppingList
//
//  Created by Olya Lutsyk on 4/13/17.
//
//

import UIKit
import YTBarButtonItemWithBadge

class ProductsViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    let shop = Shop()
    var products:[Product] = []
    let buttonWithBadge = YTBarButtonItemWithBadge()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shop.stock = [StockItem(product:Product(id:0, title:"njnjkn", price:10), quantity:2), StockItem(product:Product(id:1, title:"njnjnnkn", price:15.55), quantity:2)]
        
        
        // buttonWithBadge.setHandler(callback: onClick);
        buttonWithBadge.setImage(image: UIImage(named: "Cart")!)
        //        buttonWithBadge.setBadge(value: "10")
        self.navigationItem.setRightBarButton(buttonWithBadge.getBarButtonItem(), animated: true)
        
    }
    
    func updateBadge(quantity: Int) {
        buttonWithBadge.setBadge(value: String(quantity))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shop.availableItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        let item = shop.availableItems[indexPath.row]
        cell.configureCell(item: item)
        cell.buyAction = { (cell) in
          self.addItem(item: item)
        }
        
        return cell
    }
    
    func addItem(item:StockItem) {
        try! self.shop.addToCart(product: item.product, quantity: 1)
        self.updateBadge(quantity: self.shop.cart.items.count)
        self.navigationItem.title = String(describing: self.shop.cart.totalPrice)
        print(self.shop.cart.items.map({$0.quantity}))
    }
    
}

