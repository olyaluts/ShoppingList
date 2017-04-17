//
//  DetailViewController.swift
//  ShoppingList
//
//  Created by Olya Lutsyk on 4/13/17.
//
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  Shop.sharedShop.cart.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartProductCell", for: indexPath) as! ProductTableViewCell
        let item =  Shop.sharedShop.cart.items[indexPath.row]
        cell.configureCell(cart: item)
        cell.buttonAction = { (cell) in
            try!  Shop.sharedShop.removeFromCart(product: item.product)
            tableView.reloadData()
        }
        
        return cell
    }
    
    @IBAction func back(sender: AnyObject) {
        self.dismiss(animated: true) {
        }
    }
}

