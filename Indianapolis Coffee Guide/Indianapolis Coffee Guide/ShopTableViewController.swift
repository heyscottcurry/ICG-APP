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

    
    @IBOutlet weak var headerView: UIView!

    @IBAction func filterBack(_ sender: Any) {
            getLocale()
            shops.sort() { $0.distance < $1.distance }
            shops.removeAll()
            loadShops()
            sortList()
        
    }
    
    
    //MARK: Properties
    
    var shops = [CoffeeShop]()
    var filteredShops = [CoffeeShop]()
    var objects: [CoffeeShop] = []
    var locationManager = CLLocationManager()
   /* func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
    } */
    var currentLocation = CLLocation!.self
    var userLatitude:CLLocationDegrees! = 0
    var userLongitude:CLLocationDegrees! = 0
    var locValue:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 1.0, longitude: 1.0)
    var refresher: UIRefreshControl! = UIRefreshControl()

    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var indyHandle: UIButton!
    
    
    func getLocale() {
       
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.startMonitoringSignificantLocationChanges()
        
        userLatitude  = self.locationManager.location?.coordinate.latitude
        userLongitude = self.locationManager.location?.coordinate.longitude
        print("\(userLatitude), \(userLongitude)")
    }
    
    func sortList() {
        shops.sort() { $0.distance < $1.distance }
        self.shopTable.reloadData();
    }
    
   
    @IBOutlet weak var newLabel: UILabel!
    @IBAction func igCoffee(_ sender: UIButton) {
        
        let instagramHooks = "instagram://user?username=indianapoliscoffee"
        let instagramUrl = NSURL(string: instagramHooks)
        let fallbackURL = NSURL(string: "https://www.instagram.com/indianapoliscoffee")
        if UIApplication.shared.canOpenURL(instagramUrl! as URL)
        {
            UIApplication.shared.open(instagramUrl! as URL, options: [:], completionHandler: nil)
            
            
        } else {
            //redirect to safari because the user doesn't have Instagram
            
            UIApplication.shared.open(fallbackURL! as URL, options: [:], completionHandler: nil)
            
        }
        
    }
    
    
    @IBAction func igHashtag(_ sender: UIButton) {
        
        
        let instagramHooks = "instagram://tag?name=nomorebadcoffee"
        let instagramUrl = NSURL(string: instagramHooks)
        let fallbackURL = NSURL(string: "https://www.instagram.com/explore/tags/nomorebadcoffee/")
        if UIApplication.shared.canOpenURL(instagramUrl! as URL)
        {
            UIApplication.shared.open(instagramUrl! as URL, options: [:], completionHandler: nil)
            
            
        } else {
            //redirect to safari because the user doesn't have Instagram
            
            UIApplication.shared.open(fallbackURL! as URL, options: [:], completionHandler: nil)
            
        }
        
        
        
        
        
        
    }
    /* delete start here
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .normal, title: "              ") { action, index in
            print("more button tapped")
            
            /* let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            self.present(newViewController, animated: true, completion: nil) */
            
            
                let indexPath = tableView.indexPathForSelectedRow
                let shop = self.shops[(indexPath?.row)!]
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                self.present(newViewController, animated: true, completion: nil)
                newViewController.detailShop = shop
            

            
 
        }
       // more.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 1)

        if let image = UIImage(named: "mapmarker.png"){
            more.backgroundColor = UIColor(patternImage: image)
            
        }
        
        return [more]
    }
     
     delete this */
    
    func noHeight() {
        self.headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0)
        self.backButton.alpha = 0
    }
    
    func fullHeight() {
       self.headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        self.backButton.alpha = 1
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        shopTable.allowsMultipleSelectionDuringEditing = true
        shopTable.tableHeaderView = headerView
        
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == . authorizedWhenInUse {
            shops.removeAll()
            startTrackingLocation()
        }
        
        view.backgroundColor = UIColor.black
        
        /* userCoordinate = CLLocation(latitude: userLatitude, longitude: userLongitude) */
        
        let locValue = self.locationManager.location?.coordinate
        //noHeight()
        //loadShops()
        // sortList()
        print("\(locValue?.latitude), \(locValue?.longitude)")
        
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(ShopTableViewController.handleRefresh), for: UIControlEvents.valueChanged)
        
        
        if #available(iOS 10, *) {
            shopTable.refreshControl = refresher
        } else {
            shopTable.addSubview(refresher)
        }
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            shops.removeAll()
            startTrackingLocation()
            // ...
        }
    }
    
    func startTrackingLocation() {
        locationManager.startUpdatingLocation()
        getLocale()
        let locValue = self.locationManager.location?.coordinate
        noHeight()
        loadShops()
        sortList()
        print("\(locValue?.latitude), \(locValue?.longitude)")
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
        cell.featureThumbnail.image = shop.feature
        cell.newLabel.transform = CGAffineTransform(rotationAngle: CGFloat((M_PI_2) * -1))
        cell.newLabel.center.x = 15
        cell.newLabel.center.y = 76.5
        cell.newLabel.alpha = 0
        
        if shop.newShop == true {
            cell.newLabel.alpha = 1
        }
        if shop.distance < 0.05 {
            cell.shopDistance.text = "You must be here!"
        } else {
            cell.shopDistance.text = String(format: "%.1f", shop.distance)
            cell.shopDistance.text!.append(" miles away")
        }
        
        
         if cell.isHighlighted || cell.isSelected || cell.isFocused {
            cell.featureThumbnail.alpha = 0
                   } else {
            cell.featureThumbnail.alpha = 0.25
                    }
        
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
    
    func loadShops() {
        
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
        let featMononBR = UIImage(named: "feat-mononbroadripple")
        
        let userLocale = CLLocation(latitude: self.userLatitude, longitude: self.userLongitude)
        
        
        let shop1 = CoffeeShop(
            name: "Coat Check Coffee",
            neighborhood: "Downtown",
            long: 39.773747,
            lat: -86.150272,
            listBrew: "Tinker Coffee",
            listSpace: "Located in the old Coat Check at the historic Athenæum on Mass Ave.",
            feature: featCoatCheck!,
            newShop: true,
            igHandle: "coatcheckcoffee",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.773747, longitude: -86.150272)))*0.000621371,
            googleMap: "www.google.com/maps/place/Coat+Check+Coffee/@39.7737512,-86.1524706,17z/data=!3m1!4b1!4m5!3m4!1s0x886b50eb52c11055:0x23e6a534e092ec1f!8m2!3d39.7737471!4d-86.1502819",
            appleMap: "http://maps.apple.com/?daddr=407+E+Michigan+St,Indianapolis,IN,46204&dirflg=d&t=h"
        )
        
        let shop2 = CoffeeShop(
            name: "Georgia Street Grind",
            neighborhood: "Downtown",
            long: 39.764130,
            lat: -86.159038,
            listBrew: "In-House Blend of Local Roasts",
            listSpace: "Efficient. To the point. Perfect.",
            feature: featGeorgiaStreet!,
            newShop: true,
            igHandle: "georgiastreetgrind",
            distance:  (userLocale.distance(from: CLLocation(latitude: 39.764130, longitude: -86.159038)))*0.000621371,
            googleMap: "www.google.com/maps/place/Georgia+Street+Grind/@39.7640001,-86.1611735,17z/data=!3m1!4b1!4m5!3m4!1s0x886b50bcb3fdc199:0xa114759614410341!8m2!3d39.763996!4d-86.1589848",
            appleMap: "http://maps.apple.com/?daddr=25+W+Georgia+St,Indianapolis,IN,46225&dirflg=d&t=h"
        )
        
        let shop3 = CoffeeShop(
            name: "Quills Coffee",
            neighborhood: "Downtown",
            long: 39.779333,
            lat: -86.163894,
            listBrew: "Quills Coffee",
            listSpace: "Not your average student union.",
            feature: featQuills!,
            newShop: false,
            igHandle: "quillscoffee",
            distance:  (userLocale.distance(from: CLLocation(latitude: 39.779333, longitude: -86.163894)))*0.000621371,
            googleMap: "www.google.com/maps/place/Quills+Coffee/@39.7791461,-86.1665537,17z/data=!3m1!4b1!4m5!3m4!1s0x886b50c6067115d9:0x70e71dcb0856775!8m2!3d39.779142!4d-86.164365",
            appleMap: "http://maps.apple.com/?daddr=335+W+9th+St,Indianapolis,IN,46202&dirflg=d&t=h"
        )
        
        let shop4 = CoffeeShop(
            name: "Open Society Public House",
            neighborhood: "Broad Ripple",
            long: 39.842720,
            lat: -86.145911,
            listBrew: "Tinker Coffee & Madcap Coffee (Grand Rapids)",
            listSpace: "Half coffee shop, half restaurant & bar.",
            feature: featOpenSociety!,
            newShop: false,
            igHandle: "opensocietyindy",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.842720, longitude: -86.145911)))*0.000621371,
            googleMap: "www.google.com/maps/place/Open+Society/@39.8427236,-86.1480762,17z/data=!3m1!4b1!4m5!3m4!1s0x886b53da608f8529:0x3adc303cfa1dbd02!8m2!3d39.8427195!4d-86.1458875",
            appleMap: "http://maps.apple.com/?daddr=4850+N+College+Ave,Indianapolis,IN,46205&dirflg=d&t=h"
        )
        
        let shop5 = CoffeeShop(
            name: "Kaffeine Coffee",
            neighborhood: "Downtown",
            long: 39.776130,
            lat: -86.143894,
            listBrew: "Rotating",
            listSpace: "Comfortable, Industrial, Americana Chic",
            feature: featKaffeine!,
            newShop: false,
            igHandle: "kaffeinecoffee",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.776130, longitude: -86.143894)))*0.000621371,
            googleMap: "www.google.com/maps/place/Kaffeine+Coffee/@39.7761737,-86.1458907,17z/data=!3m1!4b1!4m5!3m4!1s0x886b572f6159e05d:0xd50f5e67c0ae3ce2!8m2!3d39.7761696!4d-86.143702",
            appleMap: "http://maps.apple.com/?daddr=707+Fulton+St+B,Indianapolis,IN,46202&dirflg=d&t=h"
        )
        
        let shop6 = CoffeeShop(
            name: "General American Donut Company",
            neighborhood: "Fountain Square",
            long: 39.755642,
            lat: -86.149328,
            listBrew: "Stumptown Coffee",
            listSpace: "Pacific Northwest meets Industrial Indy",
            feature: featGeneralAmerican!,
            newShop: false,
            igHandle: "generalamericandonut",
            distance:  (userLocale.distance(from: CLLocation(latitude: 39.755642, longitude: -86.149328)))*0.000621371,
            googleMap: "www.google.com/maps/place/Sure+Shot+Coffee/@39.9569398,-86.0179095,17z/data=!3m1!4b1!4m5!3m4!1s0x8814b3810c0e6621:0xb3ef597594be86fb!8m2!3d39.9569398!4d-86.0157208",
            appleMap: "http://maps.apple.com/?daddr=827+S+East+St,Indianapolis,IN,46225&dirflg=d&t=h"
        )
        
        let shop7 = CoffeeShop(
            name: "Bee Coffee",
            neighborhood: "Downtown",
            long: 39.763533,
            lat: -86.161663,
            listBrew: "Bee Coffee",
            listSpace: "The epitome of downtown coffee shops.",
            feature: featBee!,
            newShop: false,
            igHandle: "beecoffeeroasters",
            distance:  (userLocale.distance(from: CLLocation(latitude: 39.763533, longitude: -86.161663)))*0.000621371,
            googleMap: "www.google.com/maps/place/Bee+Coffee+Roasters/@39.7635239,-86.1636347,17z/data=!3m1!4b1!4m5!3m4!1s0x886b50a4cb935ecd:0xc62f7a0001032723!8m2!3d39.7635239!4d-86.161446",
            appleMap: "http://maps.apple.com/?daddr=Bee+Coffee+201+S+Capitol+Ave,Indianapolis,IN,46225&dirflg=d&t=h"
        )
        
        let shop8 = CoffeeShop(
            name: "Thirsty Scholar",
            neighborhood: "Downtown",
            long: 39.788278,
            lat: -86.155654,
            listBrew: "Intelligentsia",
            listSpace: "Half coffee shop. Half bar. Open late.",
            feature: featThirstyScholar!,
            newShop: false,
            igHandle: "thirstyscholarindy",
            distance:  (userLocale.distance(from: CLLocation(latitude: 39.788278, longitude: -86.155654)))*0.000621371,
            googleMap: "www.google.com/maps/place/Thirsty+Scholar/@39.7882027,-86.1577709,17z/data=!3m1!4b1!4m5!3m4!1s0x886b50ddede32ac9:0x704a683e30b7e0b!8m2!3d39.7881986!4d-86.1555822",
            appleMap: "http://maps.apple.com/?daddr=111+E+16th+St,Indianapolis,IN,46202&dirflg=d&t=h"
        )
        
        let shop9 = CoffeeShop(
            name: "Foundry Provisions",
            neighborhood: "Downtown",
            long: 39.788586,
            lat: -86.152519,
            listBrew: "Tinker Coffee",
            listSpace: "Artsy & Hip. Great for work & pleasure.",
            feature: featFoundry!,
            newShop: false,
            igHandle: "foundryindy",
            distance:  (userLocale.distance(from: CLLocation(latitude: 39.788586, longitude: -86.152519)))*0.000621371,
            googleMap: "www.google.com/maps/place/Foundry+Provisions/@39.7886279,-86.1547222,17z/data=!3m1!4b1!4m5!3m4!1s0x886b50e73986b37b:0xf89b775345e15c6a!8m2!3d39.7886238!4d-86.1525335",
            appleMap: "http://maps.apple.com/?daddr=236+E+16th+St,Indianapolis,IN,46202&dirflg=d&t=h"
        )
        
        let shop10 = CoffeeShop(
            name: "Rabble Coffee",
            neighborhood: "Irvington",
            long: 39.781211,
            lat:  -86.124265,
            listBrew: "Tinker Coffee",
            listSpace: "The neighborhood shop of your dreams.",
            feature: featRabble!,
            newShop: false,
            igHandle: "rabblecoffee",
            distance:  (userLocale.distance(from: CLLocation(latitude: 39.781211, longitude: -86.124265)))*0.000621371,
            googleMap: "www.google.com/maps/place/Rabble+Coffee/@39.7811751,-86.1264487,17z/data=!3m1!4b1!4m5!3m4!1s0x886b50452d562e3b:0x63b393cf690b13d7!8m2!3d39.781171!4d-86.12426",
            appleMap: "http://maps.apple.com/?daddr=2119+E+10th+St,Indianapolis,IN,46201&dirflg=d&t=h"
        )
        
        
        let shop11 = CoffeeShop(
            name: "Coal Yard Coffee",
            neighborhood: "Irvington",
            long: 39.767619,
            lat:  -86.071913,
            listBrew: "Rotating Organic Blends",
            listSpace: "Your favorite off-the-beaten-path shop and artist space.",
            feature: featCoalYard!,
            newShop: false,
            igHandle: "coalyardcoffee",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.767619, longitude: -86.071913)))*0.000621371,
            googleMap: "www.google.com/maps/place/Coal+Yard+Coffee/@39.7675747,-86.0740922,17z/data=!3m1!4b1!4m5!3m4!1s0x886b4f94e9752bf1:0x3989df023a70c42e!8m2!3d39.7675706!4d-86.0719035",
            appleMap: "http://maps.apple.com/?daddr=5547+Bonna+Ave,Indianapolis,IN,46219&dirflg=d&t=h"
        )
        
        let shop12 = CoffeeShop(
            name: "Neidhammer Coffee Company",
            neighborhood: "Irvington",
            long: 39.767844,
            lat: -86.125346,
            listBrew: "Carabello Coffee",
            listSpace: "A chic, industrial space that will drive your Instagram crazy.",
            feature: featNeidhammer!,
            newShop: false,
            igHandle: "neidhammercoffee",
            distance:  (userLocale.distance(from: CLLocation(latitude: 39.767844, longitude: -86.125346)))*0.000621371,
            googleMap: "www.google.com/maps/place/Neidhammer+Coffee+Co./@39.7678376,-86.1274716,17z/data=!3m1!4b1!4m5!3m4!1s0x886b506609742c2f:0x81ee299e0d466329!8m2!3d39.7678335!4d-86.1252829",
            appleMap: "http://maps.apple.com/?daddr=8684+E+116th+St,Fishers,IN,46038&dirflg=d&t=h"
        )
        
        let shop13 = CoffeeShop(
            name: "Calvin Fletcher's Coffee Company",
            neighborhood: "Fountain Square",
            long: 39.757719,
            lat: -86.145896,
            listBrew: "Roasted in house.",
            listSpace: "Always busy. Always bright.",
            feature: featCalvinFletchers!,
            newShop: false,
            igHandle: "calvinfletcherscoffeeco",
            distance:  (userLocale.distance(from: CLLocation(latitude: 39.757719, longitude: -86.145896)))*0.000621371,
            googleMap: "www.google.com/maps/place/Sure+Shot+Coffee/@39.9569398,-86.0179095,17z/data=!3m1!4b1!4m5!3m4!1s0x8814b3810c0e6621:0xb3ef597594be86fb!8m2!3d39.9569398!4d-86.0157208",
            appleMap: "http://maps.apple.com/?daddr=2102+E+Washington+St,Indianapolis,IN,46201&dirflg=d&t=h"
        )
        
        let shop14 = CoffeeShop(
            name: "VeloWorks Urban Cyclery & Coffee Shop",
            neighborhood: "Fountain Square",
            long: 39.748798,
            lat:  -86.139969,
            listBrew: "Liberation Roasting",
            listSpace: "Cozy coffee & cycle shop hybrid with loads of space.",
            feature: featVeloWorks!,
            newShop: false,
            igHandle: "veloworksindy",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.748798, longitude: -86.139969)))*0.000621371,
            googleMap: "www.google.com/maps/place/Veloworks+Urban+Cyclery+and+Coffee+Shop/@39.7487718,-86.142163,17z/data=!3m1!4b1!4m5!3m4!1s0x886b5a7949a392f9:0x508f0436a992c522!8m2!3d39.7487677!4d-86.1399743",
            appleMap: "http://maps.apple.com/?daddr=1354+Shelby+St,Indianapolis,IN,46203&dirflg=d&t=h"
        )
        
        let shop15 = CoffeeShop(
            name: "The Quirky Feather Confectionary",
            neighborhood: "Carmel",
            long: 39.956799,
            lat:  -86.141370,
            listBrew: "Hubbard & Cravens",
            listSpace: "Dr. Suess meets Willy Wonka.",
            feature: featQuirkyFeather!,
            newShop: false,
            igHandle: "quirky_feather",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.956799, longitude: -86.141370)))*0.000621371,
            googleMap: "www.google.com/maps/place/The+Quirky+Feather+Confectionery/@39.9570306,-86.1437726,17z/data=!3m1!4b1!4m5!3m4!1s0x8814acf88d300c2b:0xa1bb3db126372d5e!8m2!3d39.9570265!4d-86.1415839",
            appleMap: "http://maps.apple.com/?daddr=890+E+116th+St,Carmel,IN,46032&dirflg=d&t=h"
        )
        
        let shop16 = CoffeeShop(
            name: "Hubbard & Cravens",
            neighborhood: "Carmel",
            long: 39.970128,
            lat:  -86.128349,
            listBrew: "Hubbard & Cravens",
            listSpace: "It's a coffee shop! It's a brunch place! It's both!",
            feature: featHubbardCarmel!,
            newShop: false,
            igHandle: "hubbardcravens",
            distance:  (userLocale.distance(from: CLLocation(latitude: 39.970128, longitude: -86.128349)))*0.000621371,
            googleMap: "www.google.com/maps/place/Hubbard+%26+Cravens/@39.9701379,-86.13042,17z/data=!3m1!4b1!4m5!3m4!1s0x8814adb19b0fd041:0xfe65e9eee5ad0e9a!8m2!3d39.9701338!4d-86.1282313",
            appleMap: "http://maps.apple.com/?daddr=703+Veterans+Way,Carmel,IN,46032&dirflg=d&t=h"
        )
        
        let shop17 = CoffeeShop(
            name: "The Well Coffee House",
            neighborhood: "Fishers",
            long: 39.957169,
            lat:  -86.013124,
            listBrew: "The Well Coffee",
            listSpace: "You'll think you're in Nashville, TN.",
            feature: featTheWell!,
            newShop: false,
            igHandle: "wellcoffeehousefishers",
            distance:  (userLocale.distance(from: CLLocation(latitude: 39.957169, longitude: -86.013124)))*0.000621371,
            googleMap: "www.google.com/maps/place/The+Well+Coffeehouse+Fishers/@39.9572492,-86.0152921,17z/data=!3m1!4b1!4m5!3m4!1s0x8814b3808fd799cd:0x74cce3014924335e!8m2!3d39.9572451!4d-86.0131034",
            appleMap: "http://maps.apple.com/?daddr=8890+E+116th+St,Fishers,IN,46038&dirflg=d&t=h"
        )
        
        let shop18 = CoffeeShop(
            name: "Sure Shot Coffee",
            neighborhood: "Fishers",
            long: 39.956860,
            lat:  -86.015739,
            listBrew: "Brickhouse Coffee Roasters",
            listSpace: "The most kickass coffee counter in the most kickass t-shirt store.",
            feature: featSureShot!,
            newShop: false,
            igHandle: "sureshotcoffee",
            distance:  (userLocale.distance(from: CLLocation(latitude: 39.956860, longitude: -86.015739)))*0.000621371,
            googleMap: "www.google.com/maps/place/Sure+Shot+Coffee/@39.9569398,-86.0179095,17z/data=!3m1!4b1!4m5!3m4!1s0x8814b3810c0e6621:0xb3ef597594be86fb!8m2!3d39.9569398!4d-86.0157208",
            appleMap: "http://maps.apple.com/?daddr=8684+E+116th+St,Fishers,IN,46038&dirflg=d&t=h"
        )
        
        let shop19 = CoffeeShop(
            name: "Bee Coffee Roasters : Roastery",
            neighborhood: "Eagle Creek",
            long: 39.851262,
            lat: -86.262768,
            listBrew: "Bee Coffee (Roasted in house!)",
            listSpace: "You feel like family.",
            feature: featBeeRoaster!,
            newShop: false,
            igHandle: "beecoffeeroasters",
            distance:  (userLocale.distance(from: CLLocation(latitude: 39.851262, longitude: -86.262768)))*0.000621371,
            googleMap: "www.google.com/maps/place/Bee+Coffee+Roasters+:+Roastery/@39.8512608,-86.2649279,17z/data=!3m1!4b1!4m5!3m4!1s0x886caa0f1c04a251:0x820659e545b006a!8m2!3d39.8512567!4d-86.2627392",
            appleMap: "http://maps.apple.com/?daddr=5510+Lafayette+Rd,Indianapolis,IN,46254&dirflg=d&t=h"
        )
        
        let shop20 = CoffeeShop(
            name: "Mile Square Coffee",
            neighborhood: "Downtown",
            long: 39.768693,
            lat: -86.153339,
            listBrew: "Blue Mind & Tinker Coffee",
            listSpace: "Located on the mezzanine of the City Market.",
            feature: featMileSquare!,
            newShop: false,
            igHandle: "milesquareindy",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.768693, longitude: -86.153339)))*0.000621371,
            googleMap: "www.google.com/maps/place/Mile+Square+Coffee+Roastery+Cafe/@39.7686766,-86.1554906,17z/data=!4m5!3m4!1s0x886b5095df5cc0db:0x169b446c1008c39c!8m2!3d39.7686725!4d-86.1533019",
            appleMap: "http://maps.apple.com/?daddr=222+E+Market+St,Indianapolis,IN,46204&dirflg=d&t=h"
        )
        
        
        let shop21 = CoffeeShop(
            name: "Monon Coffee",
            neighborhood: "Broad Ripple",
            long: 39.870802,
            lat: -86.142227,
            listBrew: "Blue Mind &  Various Organic, Fair Trade Roasts",
            listSpace: "Petite & intimate. Cozy & comfortable.",
            feature: featMononBR!,
            newShop: false,
            igHandle: "mononcoffeeco",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.870802, longitude: -86.142227)))*0.000621371,
            googleMap: "www.google.com/maps/place/Monon+Coffee/@39.8708088,-86.1444162,17z/data=!3m1!4b1!4m5!3m4!1s0x886b53af2ac5ca7b:0x72d38f38a0036070!8m2!3d39.8708821!4d-86.1422512",
            appleMap: "http://maps.apple.com/?daddr=920+E+Westfield+Blvd,Indianapolis,IN,46220&dirflg=d&t=h"
        )
        
        
        
        
        
        shops += [shop1, shop2, shop3, shop4, shop5, shop6, shop7, shop8, shop9, shop10, shop11, shop12, shop13, shop14, shop15, shop16, shop17, shop18, shop19, shop20, shop21]
        
        
        
        
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

        getLocale()
        shops.sort() { $0.distance < $1.distance }
        noHeight()
        shops.removeAll()
        loadShops()
        sortList()
        refresher.endRefreshing()
        
        
    }
    
    func filterBR() {
         filteredShops = shops.filter { shops in
            return shops.neighborhood.contains("Broad Ripple")
        }
        shops = filteredShops
        self.shopTable.reloadData()
        fullHeight()

    }
    
    
    
    func filterCarmel() {
        filteredShops = shops.filter { shops in
            return shops.neighborhood.contains("Carmel")
        }
        shops = filteredShops
        self.shopTable.reloadData()
        fullHeight()
        
    }
    
    func filterDT() {
        filteredShops = shops.filter { shops in
            return shops.neighborhood.contains("Downtown")
        }
        shops = filteredShops
        self.shopTable.reloadData()
        fullHeight()
        
    }
    
    func filterFishers() {
        filteredShops = shops.filter { shops in
            return shops.neighborhood.contains("Fishers")
        }
        shops = filteredShops
        self.shopTable.reloadData()
        fullHeight()
        
    }
    
    
    func filterEC() {
        filteredShops = shops.filter { shops in
            return shops.neighborhood.contains("Eagle Creek")
        }
        shops = filteredShops
        self.shopTable.reloadData()
     fullHeight()
        
    }
    
    func filterIrvington() {
        filteredShops = shops.filter { shops in
            return shops.neighborhood.contains("Irvington")
        }
        shops = filteredShops
        self.shopTable.reloadData()
        fullHeight()
    }
    
    func filterFS() {
        filteredShops = shops.filter { shops in
            return shops.neighborhood.contains("Fountain Square")
        }
        shops = filteredShops
        self.shopTable.reloadData()
        fullHeight()
        
    }
    
    func getAll() {
        getLocale()
        shops.sort() { $0.distance < $1.distance }
        shops.removeAll()
        loadShops()
        sortList()
    }
    
    
    @IBAction func unwindFilterNav(segue: UIStoryboardSegue) {
       getAll()
        
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        noHeight()
        getAll()
    }
    
    
    
    
    @IBAction func unwindBR(_ segue: UIStoryboardSegue) {
        shops.removeAll()
        loadShops()
        filterBR()
        sortList()
    }
    
    
    @IBAction func unwindCarmel(_ segue: UIStoryboardSegue) {
        shops.removeAll()
        loadShops()
        filterCarmel()
        sortList()
    }
    
    
    @IBAction func unwindFishers(_ segue: UIStoryboardSegue) {
        shops.removeAll()
        loadShops()
        filterFishers()
        sortList()
    }
    
    @IBAction func unwindIrvington(_ segue: UIStoryboardSegue) {
        shops.removeAll()
        loadShops()
        filterIrvington()
        sortList()
        
    }
    
    @IBAction func unwindFS(_ segue: UIStoryboardSegue) {
        shops.removeAll()
        loadShops()
        filterFS()
        sortList()
        
    }
    
    @IBAction func unwindEC(_ segue: UIStoryboardSegue) {
        shops.removeAll()
        loadShops()
        filterEC()
        sortList()
        
    }
    
    @IBAction func unwindDT(_ segue: UIStoryboardSegue) {
        shops.removeAll()
        loadShops()
        filterDT()
        sortList()
        
    }
    
    
    
    
}
