//
//  MasterViewController.swift
//  ShoppingList
//
//  Created by Olya Lutsyk on 4/13/17.
//
//

import UIKit
import BadgeSwift

class ProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var products:[Product] = []
    let priceLabel = UILabel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var cartBadge: BadgeSwift!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Shop.sharedShop.stock = [StockItem(product:Product(id:0, title:"Product 1", price:10), quantity:2), StockItem(product:Product(id:1, title:"Product 2", price:15.55), quantity:2), StockItem(product:Product(id:2, title:"Product 3", price:10), quantity:2),StockItem(product:Product(id:3, title:"Product 4", price:10), quantity:2), StockItem(product:Product(id:4, title:"Product 5", price:10), quantity:2), StockItem(product:Product(id:5, title:"Product 6", price:10), quantity:2), StockItem(product:Product(id:6, title:"Product 7", price:10), quantity:2), StockItem(product:Product(id:7, title:"Product 8", price:10), quantity:2), StockItem(product:Product(id:8, title:"Product 9", price:10), quantity:2),StockItem(product:Product(id:9, title:"Product 10", price:10), quantity:2),StockItem(product:Product(id:10, title:"Product 11", price:10), quantity:2),StockItem(product:Product(id:11, title:"Product 12", price:10), quantity:2),StockItem(product:Product(id:12, title:"Product 13", price:10), quantity:2),StockItem(product:Product(id:13, title:"Product 14", price:10), quantity:2),StockItem(product:Product(id:14, title:"Product 15", price:10), quantity:2),StockItem(product:Product(id:15, title:"Product 16", price:10), quantity:2),StockItem(product:Product(id:16, title:"Product 17", price:10), quantity:2),StockItem(product:Product(id:17, title:"Product 18", price:10), quantity:2),StockItem(product:Product(id:18, title:"Product 19", price:10), quantity:2), StockItem(product:Product(id:19, title:"Product 20", price:10), quantity:2)]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateBadge(quantity: Int) {
        cartBadge.text = "\(quantity)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  Shop.sharedShop.availableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        updateBadge(quantity: Shop.sharedShop.cart.items.count)
        if (Shop.sharedShop.cart.items.count > 0) {
            cartButton.setTitle("\(Shop.sharedShop.cart.totalPrice)", for: .normal)
            cartBadge.isHidden = false
        } else {
            cartButton.setTitle("", for: .normal)
            cartBadge.isHidden = true
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func cartClicked(sender: UIButton) {
        self.performSegue(withIdentifier: "listToCart", sender: self)

    }
    
    
    
    
    
}

