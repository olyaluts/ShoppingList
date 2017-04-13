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
    
    var products:[Product] = []
    let buttonWithBadge = YTBarButtonItemWithBadge()
    let priceLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Shop.sharedShop.stock = [StockItem(product:Product(id:0, title:"Product 1", price:10), quantity:2), StockItem(product:Product(id:1, title:"Product 2", price:15.55), quantity:2)]
        
        
        buttonWithBadge.setHandler(callback: showCart)
        buttonWithBadge.setImage(image: UIImage(named: "Cart")!)
        self.navigationItem.setRightBarButton(buttonWithBadge.getBarButtonItem(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
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
        return  Shop.sharedShop.availableItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        let item = Shop.sharedShop.availableItems[indexPath.row]
        cell.configureCell(item: item)
        cell.buttonAction = { (cell) in
            try! Shop.sharedShop.addToCart(product: item.product, quantity: 1)
            self.updateUI()
        }
        
        return cell
    }
    
    func updateUI() {
        self.updateBadge(quantity: Shop.sharedShop.cart.items.count)
        self.navigationItem.title = String(describing: Shop.sharedShop.cart.totalPrice)
        tableView.reloadData()
    }
    
    func showCart() {

        self.performSegue(withIdentifier: "listToCart", sender: self)        
    }
    
  
    
    
}

