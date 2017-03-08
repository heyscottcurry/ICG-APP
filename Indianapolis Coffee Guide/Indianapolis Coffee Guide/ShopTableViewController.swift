//
//  ShopTableViewController.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 3/4/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ShopTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    
    
    @IBOutlet var shopTable: UITableView!
    
    
    //MARK: Properties
    
    var shops = [CoffeeShop]()
    var locationManager: CLLocationManager!
    var currentLocation = CLLocation!.self
    var userLatitude:CLLocationDegrees! = 0
    var userLongitude:CLLocationDegrees! = 0
    /* var userCoordinate = CLLocation(latitude: 1.0, longitude: 1.0) */
    var locValue:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 1.0, longitude: 1.0)
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
     
        
        
        handleRefresh()
        
        self.locationManager = CLLocationManager()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        view.backgroundColor = UIColor.gray
        
        
        if CLLocationManager.locationServicesEnabled()
            
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startMonitoringSignificantLocationChanges()
            self.locationManager.startUpdatingLocation()
            userLatitude  = locationManager.location!.coordinate.latitude
            userLongitude = locationManager.location!.coordinate.longitude
            
        }
        /* userCoordinate = CLLocation(latitude: userLatitude, longitude: userLongitude) */
        locValue = locationManager.location!.coordinate
        
        
        
        
       
  
        
        loadShops()
        func sortList() { // should probably be called sort and not filter
            shops.sort() { $0.neighborhood < $1.neighborhood } // sort the fruit by name
            self.shopTable.reloadData(); // notify the table view the data has changed
        }
        sortList()
        print("\(locValue.latitude), \(locValue.longitude)")
        
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
        
        let shopLocale = CLLocation(latitude: shop.long, longitude: shop.lat)
        let userLocale = CLLocation(latitude: userLatitude, longitude: userLongitude)
        
        let distanceInMeters = userLocale.distance(from: shopLocale)
        let distanceinMiles = (distanceInMeters*0.000621371)
        let distanceText = String(format: "%.1f", distanceinMiles)
        
        cell.shopDistance.text = String(" \(distanceText) miles away")
        cell.shopName.text = shop.name
        cell.shopNeighborhood.text = shop.neighborhood
        cell.featureThumbnail.image = shop.feature
        
        
        
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
        
        let featCoatCheck = UIImage(named: "feat-coatcheck")
        let featGeorgiaStreet = UIImage(named: "feat-georgiastreet")
        let featQuills = UIImage(named: "feat-quills")
        let featOpenSociety = UIImage(named: "feat-opensociety")
        let featKaffeine = UIImage(named: "feat-kaffeine")
        let featGeneralAmerican = UIImage(named: "feat-generalamerican")
        let featBee = UIImage(named: "feat-bee")
        let featThirstyScholar = UIImage(named: "feat-thirstyscholar")
        let featFoundry = UIImage(named: "feat-foundry")
        let featRabble = UIImage(named: "feat-rabble")
        let featCoalYard = UIImage(named: "feat-coalyard")
        let featNeidhammer = UIImage(named: "feat-neidhammer")
        let featCalvinFletchers = UIImage(named: "feat-calvinfletcher")
        let featVeloWorks = UIImage(named: "feat-veloworks")
        let featQuirkyFeather = UIImage(named: "feat-quirkyfeather")
        let featHubbardCarmel = UIImage(named: "feat-hubbardcarmel")
        let featTheWell = UIImage(named: "feat-thewell")
        let featSureShot = UIImage(named: "feat-sureshot")
        let featBeeRoaster = UIImage(named: "feat-beeroaster")
        let featMileSquare = UIImage(named: "feat-milesquare")
        
        
        
        
        let shop1 = CoffeeShop(
            name: "Coat Check Coffee",
            neighborhood: "Downtown",
            long: 39.773747,
            lat: -86.150272,
            listBrew: " ",
            listSpace: " ",
            feature: featCoatCheck!,
            newShop: false
        )
        
        let shop2 = CoffeeShop(
            name: "Georgia Street Grind",
            neighborhood: "Downtown",
            long: 39.764130,
            lat: -86.159038,
            listBrew: " ",
            listSpace: " ",
            feature: featGeorgiaStreet!,
            newShop: false
        )
        
        let shop3 = CoffeeShop(
            name: "Quills Coffee",
            neighborhood: "Downtown",
            long: 39.779333,
            lat: -86.163894,
            listBrew: " ",
            listSpace: " ",
            feature: featQuills!,
            newShop: false
        )
        
        let shop4 = CoffeeShop(
            name: "Open Society Public House",
            neighborhood: "Broad Ripple",
            long: 39.842720,
            lat: -86.145911,
            listBrew: " ",
            listSpace: " ",
            feature: featOpenSociety!,
            newShop: false
        )
        
        let shop5 = CoffeeShop(
            name: "Kaffeine Coffee",
            neighborhood: "Downtown",
            long: 39.776130,
            lat: -86.143894,
            listBrew: " ",
            listSpace: " ",
            feature: featKaffeine!,
            newShop: false
        )
        
        let shop6 = CoffeeShop(
            name: "General American Donut Company",
            neighborhood: "Fountain Square",
            long: 39.755642,
            lat: -86.149328,
            listBrew: " ",
            listSpace: " ",
            feature: featGeneralAmerican!,
            newShop: false
        )
        
        let shop7 = CoffeeShop(
            name: "Bee Coffee",
            neighborhood: "Downtown",
            long: 39.763533,
            lat: -86.161663,
            listBrew: " ",
            listSpace: " ",
            feature: featBee!,
            newShop: false
        )
        
        let shop8 = CoffeeShop(
            name: "Thirsty Scholar",
            neighborhood: "Downtown",
            long: 39.788278,
            lat: -86.155654,
            listBrew: " ",
            listSpace: " ",
            feature: featThirstyScholar!,
            newShop: false
        )
        
        let shop9 = CoffeeShop(
            name: "Foundry Provisions",
            neighborhood: "Downtown",
            long: 39.788586,
            lat: -86.152519,
            listBrew: " ",
            listSpace: " ",
            feature: featFoundry!,
            newShop: false
        )
        
        let shop10 = CoffeeShop(
            name: "Rabble Coffee",
            neighborhood: "Irvington",
            long: 39.781211,
            lat:  -86.124265,
            listBrew: " ",
            listSpace: " ",
            feature: featRabble!,
            newShop: false
        )
        
        
        let shop11 = CoffeeShop(
            name: "Coal Yard Coffee",
            neighborhood: "Irvington",
            long: 39.767619,
            lat:  -86.071913,
            listBrew: " ",
            listSpace: " ",
            feature: featCoalYard!,
            newShop: false
        )
        
        let shop12 = CoffeeShop(
            name: "Neidhammer Coffee Company",
            neighborhood: "Irvington",
            long: 39.767844,
            lat: -86.125346,
            listBrew: " ",
            listSpace: " ",
            feature: featNeidhammer!,
            newShop: false
        )
        
        let shop13 = CoffeeShop(
            name: "Calvin Fletcher's Coffee Company",
            neighborhood: "Fountain Square",
            long: 39.757719,
            lat: -86.145896,
            listBrew: " ",
            listSpace: " ",
            feature: featCalvinFletchers!,
            newShop: false
        )
        
        let shop14 = CoffeeShop(
            name: "VeloWorks Urban Cyclery & Coffee Shop",
            neighborhood: "Fountain Square",
            long: 39.748798,
            lat:  -86.139969,
            listBrew: " ",
            listSpace: " ",
            feature: featVeloWorks!,
            newShop: false
        )
        
        let shop15 = CoffeeShop(
            name: "The Quirky Feather Confectionary",
            neighborhood: "Carmel",
            long: 39.956799,
            lat:  -86.141370,
            listBrew: " ",
            listSpace: " ",
            feature: featQuirkyFeather!,
            newShop: false
        )
        
        let shop16 = CoffeeShop(
            name: "Hubbard & Cravens",
            neighborhood: "Carmel",
            long: 39.970128,
            lat:  -86.128349,
            listBrew: " ",
            listSpace: " ",
            feature: featHubbardCarmel!,
            newShop: false
        )
        
        let shop17 = CoffeeShop(
            name: "The Well Coffee House",
            neighborhood: "Fishers",
            long: 39.957169,
            lat:  -86.013124,
            listBrew: " ",
            listSpace: " ",
            feature: featTheWell!,
            newShop: false
        )
        
        let shop18 = CoffeeShop(
            name: "Sure Shot Coffee",
            neighborhood: "Fishers",
            long: 39.956860,
            lat:  -86.015739,
            listBrew: " ",
            listSpace: " ",
            feature: featSureShot!,
            newShop: false
        )
        
        let shop19 = CoffeeShop(
            name: "Bee Coffee Roasters : Roastery",
            neighborhood: "Eagle Creek",
            long: 39.851262,
            lat: -86.262768,
            listBrew: " ",
            listSpace: " ",
            feature: featBeeRoaster!,
            newShop: false
        )
        
        let shop20 = CoffeeShop(
            name: "Mile Square Coffee",
            neighborhood: "Downtown",
            long: 39.768693,
            lat: -86.153339,
            listBrew: " ",
            listSpace: " ",
            feature: featMileSquare!,
            newShop: false
        )
        
        
        

        
        
        
        
        shops += [shop1, shop2, shop3, shop4, shop5, shop6, shop7, shop8, shop9, shop10, shop11, shop12, shop13, shop14, shop15, shop16, shop17, shop18, shop19, shop20]
        
        
     
        
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
    
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    
    
    
    func handleRefresh() {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        refreshControl = UIRefreshControl()
        
        refreshControl?.backgroundColor = UIColor.red
        refreshControl?.tintColor = UIColor.yellow
        
        
        shopTable.addSubview(refreshControl!)
        
        // Simply adding an object to the data source for this example
        
        shops.sort() { $0.neighborhood > $1.neighborhood }
        
        self.shopTable.reloadData()
        refreshControl?.endRefreshing()
    }
    
    

}
