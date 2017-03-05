//
//  ShopTableViewController.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 3/4/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit
import MapKit

class ShopTableViewController: UITableViewController {

    
    // MARK: - location manager to authorize user location for Maps app
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    
    //MARK: Properties
    
    var shops = [CoffeeShop]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadShops()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
   
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shops.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cellIdentifier = "CoffeeShopTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CoffeeShopTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CoffeeShopTableViewCell.")
        }

        // Configure the cell...
        
        
        // Fetches the appropriate coffee shop for the data source layout.
        let shop = shops[indexPath.row]
        
        cell.shopName.text = shop.name
        cell.shopNeighborhood.text = shop.neighborhood
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    //MARK: Private Methods
    
    private func loadShops() {
        /* let photo1 = UIImage(named: "meal1")
         let photo2 = UIImage(named: "meal2")
         let photo3 = UIImage(named: "meal3")*/
        
        
        
        
        let shop1 = CoffeeShop(
            name: "Coat Check Coffee",
            neighborhood: "Downtown",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop2 = CoffeeShop(
            name: "Georgia Street Grind",
            neighborhood: "Downtown",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop3 = CoffeeShop(
            name: "Quills Coffee",
            neighborhood: "Downtown",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop4 = CoffeeShop(
            name: "Open Society Public House",
            neighborhood: "Broad Ripple",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop5 = CoffeeShop(
            name: "Kaffeine Coffee",
            neighborhood: "Downtown",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop6 = CoffeeShop(
            name: "General American Donut Company",
            neighborhood: "Fountain Square",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop7 = CoffeeShop(
            name: "Bee Coffee",
            neighborhood: "Downtown",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop8 = CoffeeShop(
            name: "Thirsty Scholar",
            neighborhood: "Downtown",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop9 = CoffeeShop(
            name: "Foundry Provisions",
            neighborhood: "Downtown",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop10 = CoffeeShop(
            name: "Rabble Coffee",
            neighborhood: "Irvington",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        
        let shop11 = CoffeeShop(
            name: "Coal Yard Coffee",
            neighborhood: "Irvington",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop12 = CoffeeShop(
            name: "Neidhammer Coffee Company",
            neighborhood: "Irvington",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop13 = CoffeeShop(
            name: "Calvin Fletcher's Coffee Company",
            neighborhood: "Fountain Square",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop14 = CoffeeShop(
            name: "VeloWorks Urban Cyclery & Coffee Shop",
            neighborhood: "Fountain Square",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop15 = CoffeeShop(
            name: "The Quirky Feather Confectionary",
            neighborhood: "Carmel",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop16 = CoffeeShop(
            name: "Hubbard & Cravens",
            neighborhood: "Carmel",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop17 = CoffeeShop(
            name: "The Well Coffee House",
            neighborhood: "Fishers",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop18 = CoffeeShop(
            name: "Sure Shot Coffee",
            neighborhood: "Fishers",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )
        
        let shop19 = CoffeeShop(
            name: "Bee Coffee Roasters : Roastery",
            neighborhood: "Eagle Creek",
            long: 39.941468,
            lat: -86.149626,
            listBrew: " ",
            listSpace: " "
        )

        
        
        
        
        
        
        
        
        shops += [shop1, shop2, shop3, shop4, shop5, shop6, shop7, shop8, shop9, shop10, shop11, shop12, shop13, shop14, shop15, shop16, shop17, shop18, shop19]
    }
    
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let shop = shops[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! ShopDetail
                controller.detailShop = shop
            }
        }
    }
    

}
