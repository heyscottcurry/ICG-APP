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
    // delete start here
    /*  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     return true
     }
     
     
     override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
     let more = UITableViewRowAction(style: .normal, title: "              ") { action, index in
     print("more button tapped")
     
     /* let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
     let newViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
     self.present(newViewController, animated: true, completion: nil) */
     
     
     /*     let indexPath = tableView.indexPathForSelectedRow
     let shop = self.shops[(indexPath?.row)!]
     let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
     let newViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
     self.present(newViewController, animated: true, completion: nil)
     newViewController.detailShop = shop */
     
     }
     // more.backgroundColor = UIColor(displayP3Red: 217/255, green: 83/255, blue: 79/255, alpha: 1)
     
     if let image = UIImage(named: "mapmarker.png"){
     more.backgroundColor = UIColor(patternImage: image)
     
     }
     
     return [more]
     } */
    
    // delete this
    
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
        } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            shops.removeAll()
            startTrackingLocation()
        } else if CLLocationManager.authorizationStatus() == .denied {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "noLocation")
            self.present(newViewController, animated: true, completion: nil)
        }
        
        view.backgroundColor = UIColor.black
        //        shopTable.backgroundColor = UIColor(displayP3Red: 217/255, green: 83/255, blue: 79/255, alpha: 1)
        shopTable.backgroundColor = UIColor.black
        
        /* userCoordinate = CLLocation(latitude: userLatitude, longitude: userLongitude) */
        
        let locValue = self.locationManager.location?.coordinate
        //noHeight()
        //loadShops()
        // sortList()
        print("\(String(describing: locValue?.latitude)), \(String(describing: locValue?.longitude))")
        
        refresher = UIRefreshControl()
        
        refresher.addTarget(self, action: #selector(ShopTableViewController.handleRefresh), for: UIControlEvents.valueChanged)
        
        
        if #available(iOS 10, *) {
            shopTable.refreshControl = refresher
            shopTable.refreshControl?.backgroundColor = UIColor.black
            
        } else {
            shopTable.addSubview(refresher)
            shopTable.refreshControl?.backgroundColor = UIColor.black
        }
        
        
        
        
        
    }
    
    
    
    
    var day = Calendar.current.component(.weekday, from: Date())
    var time = (Double(Calendar.current.component(.hour, from: Date()) * 100) + Double(Calendar.current.component(.minute, from: Date())))
    
    
    func roundDown(_ value: Double, toNearest: Double) -> Double {
        return floor(value / toNearest) * toNearest
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            shops.removeAll()
            startTrackingLocation()
        } 
    }
    
    func startTrackingLocation() {
        locationManager.startUpdatingLocation()
        getLocale()
        let locValue = self.locationManager.location?.coordinate
        noHeight()
        loadShops()
        sortList()
        print("\(String(describing: locValue?.latitude)), \(String(describing: locValue?.longitude))")
        print(self.day)
        print(self.time)
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
        
        self.day = Calendar.current.component(.weekday, from: Date())
        self.time = (Double(Calendar.current.component(.hour, from: Date()) * 100) + Double(Calendar.current.component(.minute, from: Date())))
        
        
        
        cell.shopName.text = shop.name
        cell.shopNeighborhood.text = shop.neighborhood
        cell.featureThumbnail.image = shop.feature
        cell.newLabel.transform = CGAffineTransform(rotationAngle: CGFloat((Double.pi / 2) * -1))
        cell.newLabel.center.x = 0
        cell.newLabel.center.y = 76.5
        cell.newLabel.alpha = 0
        cell.openImage.alpha = 0.25
        cell.openImage.image = UIImage(named: "clock-off")
        cell.soonText.alpha = 0
        
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
        
        
        // cell.shopName.alpha = 0.4
        
        
        
        
        let day = Double(self.day)
        let time = Double(self.time)
        
        if day == 1 && shop.sundayOpen < time && shop.sundayClose > time {
            shop.isOpen = true
        } else if day == 2 && shop.mondayOpen < time && shop.mondayClose > time {
            shop.isOpen = true
        } else if day == 3 && shop.tuesdayOpen < time && shop.tuesdayClose > time {
            shop.isOpen = true
        } else if day == 4 && shop.wednesdayOpen < time && shop.wednesdayClose > time {
            shop.isOpen = true
        } else if day == 5 && shop.thursdayOpen < time && shop.thursdayClose > time {
            shop.isOpen = true
        } else if day == 6 && shop.fridayOpen < time && shop.fridayClose > time {
            shop.isOpen = true
        } else if day == 7 && shop.saturdayOpen < time && shop.saturdayClose > time {
            shop.isOpen = true
        }
        
        if shop.isOpen == true {
           // cell.shopName.alpha = 1
            cell.openImage.alpha = 1
            cell.openImage.image = UIImage(named: "clock-on")
        }

        
        if shop.isOpen != true && day == 1 && (shop.sundayOpen - time) < 100 && (shop.sundayOpen - time) > 0 {
            let hour = roundDown(shop.sundayOpen, toNearest: 100)
            var twelveHour = hour / 100
            if twelveHour > 12 {
                twelveHour = twelveHour - 12
            }
            let minutes = Int(shop.sundayOpen - hour)
            cell.soonText.text = "Opens at \(Int(twelveHour)):\(String(format: "%02d", minutes))"

            cell.soonText.alpha = 1
            cell.openImage.alpha = 0
        } else if shop.isOpen != true && day == 2 && (shop.mondayOpen - time) < 100 && (shop.mondayOpen - time) > 0 {
            let hour = roundDown(shop.mondayOpen, toNearest: 100)
            var twelveHour = hour / 100
            if twelveHour > 12 {
                twelveHour = twelveHour - 12
            }
            let minutes = Int(shop.mondayOpen - hour)
            cell.soonText.text = "Opens at \(Int(twelveHour)):\(String(format: "%02d", minutes))"
            cell.soonText.alpha = 1
            cell.openImage.alpha = 0
        } else if shop.isOpen != true && day == 3 && (shop.tuesdayOpen  - time) < 100 && (shop.tuesdayOpen - time) > 0 {
            let hour = roundDown(shop.tuesdayOpen, toNearest: 100)
            var twelveHour = hour / 100
            if twelveHour > 12 {
                twelveHour = twelveHour - 12
            }
            let minutes = Int(shop.tuesdayOpen - hour)
            cell.soonText.text = "Opens at \(Int(twelveHour)):\(String(format: "%02d", minutes))"
            cell.soonText.alpha = 1
            cell.openImage.alpha = 0
        } else if shop.isOpen != true && day == 4 && (shop.wednesdayOpen - time) < 100  && (shop.wednesdayOpen - time) > 0 {
            let hour = roundDown(shop.wednesdayOpen, toNearest: 100)
            var twelveHour = hour / 100
            if twelveHour > 12 {
                twelveHour = twelveHour - 12
            }
            let minutes = Int(shop.wednesdayOpen - hour)
            cell.soonText.text = "Opens at \(Int(twelveHour)):\(String(format: "%02d", minutes))"
            cell.soonText.alpha = 1
            cell.openImage.alpha = 0
        } else if shop.isOpen != true && day == 5 && (shop.thursdayOpen - time) < 100  && (shop.thursdayOpen - time) > 0 {
            let hour = roundDown(shop.thursdayOpen, toNearest: 100)
            var twelveHour = hour / 100
            if twelveHour > 12 {
                twelveHour = twelveHour - 12
            }
            let minutes = Int(shop.thursdayOpen - hour)
            cell.soonText.text = "Opens at \(Int(twelveHour)):\(String(format: "%02d", minutes))"
            cell.soonText.alpha = 1
            cell.openImage.alpha = 0
        } else if shop.isOpen != true && day == 6 && (shop.fridayOpen - time) < 100 && (shop.fridayOpen - time) > 0  {
            let hour = roundDown(shop.fridayOpen, toNearest: 100)
            var twelveHour = hour / 100
            if twelveHour > 12 {
                twelveHour = twelveHour - 12
            }
            let minutes = Int(shop.fridayOpen - hour)
            cell.soonText.text = "Opens at \(Int(twelveHour)):\(String(format: "%02d", minutes))"
            cell.soonText.alpha = 1
            cell.openImage.alpha = 0
        } else if shop.isOpen != true && day == 7 && (shop.saturdayOpen  - time) < 100 && (shop.saturdayOpen - time) > 0  {
            let hour = roundDown(shop.saturdayOpen, toNearest: 100)
            var twelveHour = hour / 100
            if twelveHour > 12 {
                twelveHour = twelveHour - 12
            }
            let minutes = Int(shop.saturdayOpen - hour)
            cell.soonText.text = "Opens at \(Int(twelveHour)):\(String(format: "%02d", minutes))"
            cell.soonText.alpha = 1
            cell.openImage.alpha = 0
        }
        
        
        
        if shop.isOpen == true && day == 1 && (shop.sundayClose - time) < 100 && (shop.sundayClose - time) > 0 {
            let hour = roundDown(shop.sundayClose, toNearest: 100)
            var twelveHour = hour / 100
            if twelveHour > 12 {
                twelveHour = twelveHour - 12
            }
            let minutes = Int(shop.sundayClose - hour)
            cell.soonText.text = "Closes at \(Int(twelveHour)):\(String(format: "%02d", minutes))"
            
            cell.soonText.alpha = 1
            cell.openImage.alpha = 0
            
        } else if shop.isOpen == true && day == 2 && (shop.mondayClose - time) < 100 && (shop.mondayClose - time) > 0 {
            let hour = roundDown(shop.mondayClose, toNearest: 100)
            var twelveHour = hour / 100
            if twelveHour > 12 {
                twelveHour = twelveHour - 12
            }
            let minutes = Int(shop.mondayClose - hour)
            cell.soonText.text = "Closes at \(Int(twelveHour)):\(String(format: "%02d", minutes))"
            cell.soonText.alpha = 1
            cell.openImage.alpha = 0
            
        } else if shop.isOpen == true && day == 3 && (shop.tuesdayClose  - time) < 100  && (shop.tuesdayClose - time) > 0 {
            let hour = roundDown(shop.tuesdayClose, toNearest: 100)
            var twelveHour = hour / 100
            if twelveHour > 12 {
                twelveHour = twelveHour - 12
            }
            let minutes = Int(shop.tuesdayClose - hour)
            cell.soonText.text = "Closes at \(Int(twelveHour)):\(String(format: "%02d", minutes))"
            cell.soonText.alpha = 1
            cell.openImage.alpha = 0
            
        } else if shop.isOpen == true && day == 4 && (shop.wednesdayClose - time) < 100  && (shop.wednesdayClose - time) > 0 {
            let hour = roundDown(shop.wednesdayClose, toNearest: 100)
            var twelveHour = hour / 100
            if twelveHour > 12 {
                twelveHour = twelveHour - 12
            }
            let minutes = Int(shop.wednesdayClose - hour)
            cell.soonText.text = "Closes at \(Int(twelveHour)):\(String(format: "%02d", minutes))"
            cell.soonText.alpha = 1
            cell.openImage.alpha = 0
            
        } else if shop.isOpen == true && day == 5 && (shop.thursdayClose - time) < 100  && (shop.thursdayClose - time) > 0 {
            let hour = roundDown(shop.thursdayClose, toNearest: 100)
            var twelveHour = hour / 100
            if twelveHour > 12 {
                twelveHour = twelveHour - 12
            }
            let minutes = Int(shop.thursdayClose - hour)
            cell.soonText.text = "Closes at \(Int(twelveHour)):\(String(format: "%02d", minutes))"
            cell.soonText.alpha = 1
            cell.openImage.alpha = 0
            
        } else if shop.isOpen == true && day == 6 && (shop.fridayClose - time) < 100 && (shop.fridayClose - time) > 0  {
            let hour = roundDown(shop.fridayClose, toNearest: 100)
            var twelveHour = hour / 100
            if twelveHour > 12 {
                twelveHour = twelveHour - 12
            }
            let minutes = Int(shop.fridayClose - hour)
            cell.soonText.text = "Closes at \(Int(twelveHour)):\(String(format: "%02d", minutes))"
            cell.soonText.alpha = 1
            cell.openImage.alpha = 0
            
        } else if shop.isOpen == true && day == 7 && (shop.saturdayClose  - time) < 100 && (shop.saturdayClose - time) > 0  {
            let hour = roundDown(shop.saturdayClose, toNearest: 100)
            var twelveHour = hour / 100
            if twelveHour > 12 {
                twelveHour = twelveHour - 12
            }
            let minutes = Int(shop.saturdayClose - hour)
            cell.soonText.text = "Closes at \(Int(twelveHour)):\(String(format: "%02d", minutes))"
            cell.soonText.alpha = 1
            cell.openImage.alpha = 0
        }
        
        
        
        print(self.day)
        print(self.time)
        
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
        let featCommissary = UIImage(named: "feat-commissary")
        let featKaffeine = UIImage(named: "feat-kaffeine")
        let featGeneralAmerican = UIImage(named: "feat-generalamerican")
        let featBee = UIImage(named: "feat-bee")
        let featMansion = UIImage(named: "feat-mansion")
        let featFoundry = UIImage(named: "feat-foundry")
        let featRabble = UIImage(named: "feat-rabble")
        let featCoalYard = UIImage(named: "feat-coalyard")
        let featNeidhammer = UIImage(named: "feat-neidhammer")
        let featCalvinFletchers = UIImage(named: "feat-calvinfletcher")
        // let featQuirkyFeather = UIImage(named: "feat-quirkyfeather")
        let featHubbardCarmel = UIImage(named: "feat-hubbardcarmel")
        let featTheWell = UIImage(named: "feat-thewell")
       //  let featSureShot = UIImage(named: "feat-sureshot")
        let featBeeRoaster = UIImage(named: "feat-beeroaster")
        let featMileSquare = UIImage(named: "feat-milesquare")
        let featMononBR = UIImage(named: "feat-mononbroadripple")
        let featIndieCoffee = UIImage(named: "feat-indiecoffee")
        let featHubbardBR = UIImage(named: "feat-hubbard49thpenn")
        let featSmashSocial = UIImage(named: "feat-smashsocial")
        let featHaverstick = UIImage(named: "feat-haverstick")
        let featDellaLava = UIImage(named: "feat-dellalava")
        let featSoHo = UIImage(named: "feat-soho")
        let featHubbardBroad = UIImage(named: "feat-hubbard-br")
        let featCoffeehouseFive = UIImage(named: "feat-coffeehouse-five")
        let featProvider = UIImage(named: "feat-provider")
        let featSquareCat = UIImage(named: "feat-square-cat")
        let featPorter = UIImage(named: "feat-porter")
        let featPorterCoffee = UIImage(named: "feat-portercoffee")
        let featGavel = UIImage(named: "feat-gavel")
        let featGreenfieldGrind = UIImage(named: "feat-greenfield-grind")
        let featNineLives = UIImage(named: "feat-nine-lives")
        
        let userLocale = CLLocation(latitude: self.userLatitude, longitude: self.userLongitude)
        
        
        let shop1 = CoffeeShop(
            name: "Coat Check Coffee",
            neighborhood: "Downtown",
            long: 39.773747,
            lat: -86.150272,
            listBrew: "Tinker Coffee",
            listSpace: "Located in the old Coat Check at the historic Athenæum on Mass Ave.",
            feature: featCoatCheck!,
            newShop: false,
            igHandle: "coatcheckcoffee",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.773747, longitude: -86.150272)))*0.000621371,
            googleMap: "www.google.com/maps/place/Coat+Check+Coffee/@39.7737512,-86.1524706,17z/data=!3m1!4b1!4m5!3m4!1s0x886b50eb52c11055:0x23e6a534e092ec1f!8m2!3d39.7737471!4d-86.1502819",
            appleMap: "http://maps.apple.com/?daddr=407+E+Michigan+St,Indianapolis,IN,46204&dirflg=d&t=h",
            mondayOpen: 0700,
            mondayClose: 1900,
            tuesdayOpen: 0700,
            tuesdayClose: 1900,
            wednesdayOpen: 0700,
            wednesdayClose: 1900,
            thursdayOpen: 0700,
            thursdayClose: 1900,
            fridayOpen: 0700,
            fridayClose: 1900,
            saturdayOpen: 0800,
            saturdayClose: 1800,
            sundayOpen: 0800,
            sundayClose: 1800,
            isOpen: false,
            isFave: false
        )
        
        let shop2 = CoffeeShop(
            name: "Georgia Street Grind",
            neighborhood: "Downtown",
            long: 39.764130,
            lat: -86.159038,
            listBrew: "In-House Blend of Local Roasts",
            listSpace: "Efficient. To the point. Perfect.",
            feature: featGeorgiaStreet!,
            newShop: false,
            igHandle: "georgiastreetgrind",
            distance:  (userLocale.distance(from: CLLocation(latitude: 39.764130, longitude: -86.159038)))*0.000621371,
            googleMap: "www.google.com/maps/place/Georgia+Street+Grind/@39.7640001,-86.1611735,17z/data=!3m1!4b1!4m5!3m4!1s0x886b50bcb3fdc199:0xa114759614410341!8m2!3d39.763996!4d-86.1589848",
            appleMap: "http://maps.apple.com/?daddr=25+W+Georgia+St,Indianapolis,IN,46225&dirflg=d&t=h",
            mondayOpen: 0730,
            mondayClose: 1730,
            tuesdayOpen: 0730,
            tuesdayClose: 1730,
            wednesdayOpen: 0730,
            wednesdayClose: 1730,
            thursdayOpen: 0730,
            thursdayClose: 1730,
            fridayOpen: 0730,
            fridayClose: 1730,
            saturdayOpen: 000,
            saturdayClose: 000,
            sundayOpen: 000,
            sundayClose: 000,
            isOpen: false,
            isFave: false
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
            appleMap: "http://maps.apple.com/?daddr=335+W+9th+St,Indianapolis,IN,46202&dirflg=d&t=h",
            mondayOpen: 0630,
            mondayClose: 1800,
            tuesdayOpen: 0630,
            tuesdayClose: 1800,
            wednesdayOpen: 0630,
            wednesdayClose: 1800,
            thursdayOpen: 0630,
            thursdayClose: 1800,
            fridayOpen: 0630,
            fridayClose: 1900,
            saturdayOpen: 0800,
            saturdayClose: 1900,
            sundayOpen: 0800,
            sundayClose: 1900,
            isOpen: false,
            isFave: false
        )
       /*
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
            appleMap: "http://maps.apple.com/?daddr=4850+N+College+Ave,Indianapolis,IN,46205&dirflg=d&t=h",
            mondayOpen: 0700,
            mondayClose: 1900,
            tuesdayOpen: 0700,
            tuesdayClose: 2200,
            wednesdayOpen: 0700,
            wednesdayClose: 2200,
            thursdayOpen: 0700,
            thursdayClose: 2200,
            fridayOpen: 0700,
            fridayClose: 2300,
            saturdayOpen: 0700,
            saturdayClose: 2300,
            sundayOpen: 0700,
            sundayClose: 1700,
         isOpen: false,
         isFave: false
        )
 */
        
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
            appleMap: "http://maps.apple.com/?daddr=707+Fulton+St+B,Indianapolis,IN,46202&dirflg=d&t=h",
            mondayOpen: 0600,
            mondayClose: 1800,
            tuesdayOpen: 0600,
            tuesdayClose: 1800,
            wednesdayOpen: 0600,
            wednesdayClose: 1800,
            thursdayOpen: 0600,
            thursdayClose: 1800,
            fridayOpen: 0600,
            fridayClose: 1800,
            saturdayOpen: 0600,
            saturdayClose: 1800,
            sundayOpen: 000,
            sundayClose: 000,
            isOpen: false,
            isFave: false
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
            googleMap: "www.google.com/maps/place/General+American+Donut+Company/@39.755631,-86.1513397,17z/data=!3m1!4b1!4m5!3m4!1s0x886b509dd2b2e36b:0xb0319e04bf3073c7!8m2!3d39.755631!4d-86.149151",
            appleMap: "http://maps.apple.com/?daddr=827+S+East+St,Indianapolis,IN,46225&dirflg=d&t=h",
            mondayOpen: 000,
            mondayClose: 000,
            tuesdayOpen: 0630,
            tuesdayClose: 1400,
            wednesdayOpen: 0630,
            wednesdayClose: 1400,
            thursdayOpen: 0630,
            thursdayClose: 1400,
            fridayOpen: 0630,
            fridayClose: 1400,
            saturdayOpen: 0730,
            saturdayClose: 1400,
            sundayOpen: 0730,
            sundayClose: 1400,
            isOpen: false,
            isFave: false
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
            appleMap: "http://maps.apple.com/?daddr=Bee+Coffee+201+S+Capitol+Ave,Indianapolis,IN,46225&dirflg=d&t=h",
            mondayOpen: 630,
            mondayClose: 1800,
            tuesdayOpen: 630,
            tuesdayClose: 1800,
            wednesdayOpen: 630,
            wednesdayClose: 1800,
            thursdayOpen: 630,
            thursdayClose: 1800,
            fridayOpen: 630,
            fridayClose: 1800,
            saturdayOpen: 0700,
            saturdayClose: 1500,
            sundayOpen: 000,
            sundayClose: 000,
            isOpen: false,
            isFave: false
        )
        
     /*   let shop8 = CoffeeShop(
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
            appleMap: "http://maps.apple.com/?daddr=111+E+16th+St,Indianapolis,IN,46202&dirflg=d&t=h",
            mondayOpen: 0800,
            mondayClose: 2359,
            tuesdayOpen: 0800,
            tuesdayClose: 2359,
            wednesdayOpen: 0800,
            wednesdayClose: 2359,
            thursdayOpen: 0800,
            thursdayClose: 2359,
            fridayOpen: 0800,
            fridayClose: 2359,
            saturdayOpen: 0900,
            saturdayClose: 2359,
            sundayOpen: 0900,
            sundayClose: 2359,
         isOpen: false,
         isFave: false
        ) */
        
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
            appleMap: "http://maps.apple.com/?daddr=236+E+16th+St,Indianapolis,IN,46202&dirflg=d&t=h",
            mondayOpen: 0700,
            mondayClose: 1800,
            tuesdayOpen: 0700,
            tuesdayClose: 1800,
            wednesdayOpen: 0700,
            wednesdayClose: 1800,
            thursdayOpen: 0700,
            thursdayClose: 1800,
            fridayOpen: 0700,
            fridayClose: 1800,
            saturdayOpen: 0800,
            saturdayClose: 1600,
            sundayOpen: 0800,
            sundayClose: 1500,
            isOpen: false,
            isFave: false
        )
        
        let shop10 = CoffeeShop(
            name: "Rabble Coffee",
            neighborhood: "Near Eastside",
            long: 39.781211,
            lat:  -86.124265,
            listBrew: "Tinker Coffee",
            listSpace: "The neighborhood shop of your dreams.",
            feature: featRabble!,
            newShop: false,
            igHandle: "rabblecoffee",
            distance:  (userLocale.distance(from: CLLocation(latitude: 39.781211, longitude: -86.124265)))*0.000621371,
            googleMap: "www.google.com/maps/place/Rabble+Coffee/@39.7811751,-86.1264487,17z/data=!3m1!4b1!4m5!3m4!1s0x886b50452d562e3b:0x63b393cf690b13d7!8m2!3d39.781171!4d-86.12426",
            appleMap: "http://maps.apple.com/?daddr=2119+E+10th+St,Indianapolis,IN,46201&dirflg=d&t=h",
            mondayOpen: 0600,
            mondayClose: 1800,
            tuesdayOpen: 0600,
            tuesdayClose: 1800,
            wednesdayOpen: 0600,
            wednesdayClose: 1800,
            thursdayOpen: 0600,
            thursdayClose: 1800,
            fridayOpen: 0600,
            fridayClose: 1800,
            saturdayOpen: 0800,
            saturdayClose: 1800,
            sundayOpen: 0800,
            sundayClose: 1500,
            isOpen: false,
            isFave: false
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
            appleMap: "http://maps.apple.com/?daddr=5547+Bonna+Ave,Indianapolis,IN,46219&dirflg=d&t=h",
            mondayOpen: 0800,
            mondayClose: 1400,
            tuesdayOpen: 0800,
            tuesdayClose: 1400,
            wednesdayOpen: 0800,
            wednesdayClose: 1400,
            thursdayOpen: 0800,
            thursdayClose: 2000,
            fridayOpen: 0800,
            fridayClose: 2000,
            saturdayOpen: 0800,
            saturdayClose: 2000,
            sundayOpen: 0900,
            sundayClose: 1800,
            isOpen: false,
            isFave: false
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
            appleMap: "http://maps.apple.com/?daddr=8684+E+116th+St,Fishers,IN,46038&dirflg=d&t=h",
            mondayOpen: 0700,
            mondayClose: 1800,
            tuesdayOpen: 0700,
            tuesdayClose: 1800,
            wednesdayOpen: 0700,
            wednesdayClose: 1800,
            thursdayOpen: 0700,
            thursdayClose: 1800,
            fridayOpen: 0700,
            fridayClose: 1800,
            saturdayOpen: 0800,
            saturdayClose: 1800,
            sundayOpen: 000,
            sundayClose: 000,
            isOpen: false,
            isFave: false
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
            googleMap: "www.google.com/maps/place/Calvin+Fletcher's+Coffee+Company/@39.7577079,-86.1482352,17z/data=!3m1!4b1!4m5!3m4!1s0x886b509b7cf4ec23:0xf1f239676978fc6e!8m2!3d39.7577079!4d-86.1460465",
            appleMap: "http://maps.apple.com/?daddr=2102+E+Washington+St,Indianapolis,IN,46201&dirflg=d&t=h",
            mondayOpen: 0700,
            mondayClose: 1800,
            tuesdayOpen: 0700,
            tuesdayClose: 1800,
            wednesdayOpen: 0700,
            wednesdayClose: 1800,
            thursdayOpen: 0700,
            thursdayClose: 1800,
            fridayOpen: 0700,
            fridayClose: 1800,
            saturdayOpen: 0700,
            saturdayClose: 1800,
            sundayOpen: 000,
            sundayClose: 000,
            isOpen: false,
            isFave: false
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
            appleMap: "http://maps.apple.com/?daddr=703+Veterans+Way,Carmel,IN,46032&dirflg=d&t=h",
            mondayOpen: 0630,
            mondayClose: 1900,
            tuesdayOpen: 0630,
            tuesdayClose: 1900,
            wednesdayOpen: 0630,
            wednesdayClose: 1900,
            thursdayOpen: 0630,
            thursdayClose: 1900,
            fridayOpen: 0630,
            fridayClose: 1900,
            saturdayOpen: 0730,
            saturdayClose: 1900,
            sundayOpen: 0730,
            sundayClose: 1900,
            isOpen: false,
            isFave: false
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
            appleMap: "http://maps.apple.com/?daddr=8890+E+116th+St,Fishers,IN,46038&dirflg=d&t=h",
            mondayOpen: 0600,
            mondayClose: 2100,
            tuesdayOpen: 0600,
            tuesdayClose: 2100,
            wednesdayOpen: 0600,
            wednesdayClose: 2100,
            thursdayOpen: 0600,
            thursdayClose: 2100,
            fridayOpen: 0600,
            fridayClose: 2100,
            saturdayOpen: 0800,
            saturdayClose: 2100,
            sundayOpen: 0900,
            sundayClose: 1800,
            isOpen: false,
            isFave: false
        )
        
      /*   let shop18 = CoffeeShop(
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
            appleMap: "http://maps.apple.com/?daddr=8684+E+116th+St,Fishers,IN,46038&dirflg=d&t=h",
            mondayOpen: 0700,
            mondayClose: 2000,
            tuesdayOpen: 0700,
            tuesdayClose: 2000,
            wednesdayOpen: 0700,
            wednesdayClose: 2000,
            thursdayOpen: 0700,
            thursdayClose: 2000,
            fridayOpen: 0700,
            fridayClose: 2000,
            saturdayOpen: 0800,
            saturdayClose: 2000,
            sundayOpen: 0900,
            sundayClose: 1600,
         isOpen: false,
         isFave: false
        ) */
        
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
            appleMap: "http://maps.apple.com/?daddr=5510+Lafayette+Rd,Indianapolis,IN,46254&dirflg=d&t=h",
            mondayOpen: 0600,
            mondayClose: 1730,
            tuesdayOpen: 0600,
            tuesdayClose: 1730,
            wednesdayOpen: 0600,
            wednesdayClose: 1730,
            thursdayOpen: 0600,
            thursdayClose: 1730,
            fridayOpen: 0600,
            fridayClose: 1730,
            saturdayOpen: 0700,
            saturdayClose: 1500,
            sundayOpen: 000,
            sundayClose: 000,
            isOpen: false,
            isFave: false
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
            appleMap: "http://maps.apple.com/?daddr=222+E+Market+St,Indianapolis,IN,46204&dirflg=d&t=h",
            mondayOpen: 0800,
            mondayClose: 1500,
            tuesdayOpen: 0800,
            tuesdayClose: 1500,
            wednesdayOpen: 0800,
            wednesdayClose: 1500,
            thursdayOpen: 0800,
            thursdayClose: 1500,
            fridayOpen: 0800,
            fridayClose: 1500,
            saturdayOpen: 0830,
            saturdayClose: 1500,
            sundayOpen: 000,
            sundayClose: 000,
            isOpen: false,
            isFave: false
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
            appleMap: "http://maps.apple.com/?daddr=920+E+Westfield+Blvd,Indianapolis,IN,46220&dirflg=d&t=h",
            mondayOpen: 0630,
            mondayClose: 2000,
            tuesdayOpen: 0630,
            tuesdayClose: 2000,
            wednesdayOpen: 0630,
            wednesdayClose: 2000,
            thursdayOpen: 0630,
            thursdayClose: 2000,
            fridayOpen: 0630,
            fridayClose: 2100,
            saturdayOpen: 0700,
            saturdayClose: 2100,
            sundayOpen: 0800,
            sundayClose: 2000,
            isOpen: false,
            isFave: false
        )
        
        let shop22 = CoffeeShop(
            name: "Indie Coffee Roasters",
            neighborhood: "Carmel",
            long: 39.978650,
            lat: -86.124047,
            listBrew: "Roasted in house!",
            listSpace: "Bright, polished, on-brand. ",
            feature: featIndieCoffee!,
            newShop: false,
            igHandle: "indiecoffeeroasters",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.978650, longitude: -86.124047)))*0.000621371,
            googleMap: "www.google.com/maps/place/Indie+Coffee+Roasters/@39.9786489,-86.1262371,17z/data=!3m1!4b1!4m5!3m4!1s0x8814adc7fc677f39:0xf94beb2652d288d5!8m2!3d39.9786448!4d-86.1240484",
            appleMap: "http://maps.apple.com/?daddr=220+E+Main+Street,Carmel,IN,46032&dirflg=d&t=h",
            mondayOpen: 700,
            mondayClose: 1800,
            tuesdayOpen: 0700,
            tuesdayClose: 1800,
            wednesdayOpen: 0700,
            wednesdayClose: 1800,
            thursdayOpen: 0700,
            thursdayClose: 1800,
            fridayOpen: 0700,
            fridayClose: 1800,
            saturdayOpen: 0700,
            saturdayClose: 1800,
            sundayOpen: 000,
            sundayClose: 000,
            isOpen: false,
            isFave: false
        )
        
        let shop23 = CoffeeShop(
            name: "Hubbard & Cravens",
            neighborhood: "Broad Ripple",
            long: 39.8434367,
            lat: -86.1573993,
            listBrew: "Roasted just down the street.",
            listSpace: "Classic neighborhood coffeehouse.",
            feature: featHubbardBR!,
            newShop: false,
            igHandle: "hubbardandcravens",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.8434367, longitude: -86.1573993)))*0.000621371,
            googleMap: "www.google.com/maps/place/Hubbard+%26+Cravens+Coffee+Co/@39.8434367,-86.1573993,17z/data=!3m1!4b1!4m5!3m4!1s0x886b53e78182bd45:0xdc59d6beac8b01e0!8m2!3d39.8434326!4d-86.1552106",
            appleMap: "http://maps.apple.com/?daddr=4930+N+Pennsylvania+Street,Indianapolis,IN,46205&dirflg=d&t=h",
            mondayOpen: 0530,
            mondayClose: 1900,
            tuesdayOpen: 0530,
            tuesdayClose: 1900,
            wednesdayOpen: 0530,
            wednesdayClose: 1900,
            thursdayOpen: 0530,
            thursdayClose: 1900,
            fridayOpen: 0530,
            fridayClose: 1900,
            saturdayOpen: 0600,
            saturdayClose: 1900,
            sundayOpen: 0700,
            sundayClose: 1700,
            isOpen: false,
            isFave: false
        )
        
        let shop24 = CoffeeShop(
            name: "Smash Social",
            neighborhood: "Downtown",
            long: 39.770072,
            lat: -86.146946,
            listBrew: "Tinker Coffee",
            listSpace: "Coffee + Beer + Ping Pong.",
            feature: featSmashSocial!,
            newShop: false,
            igHandle: "smashsocialhq",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.770072, longitude: -86.146946)))*0.000621371,
            googleMap: "www.google.com/maps/place/Smash+Social/@39.7700614,-86.1491555,17z/data=!3m1!4b1!4m5!3m4!1s0x886b50924c739b9f:0x867c52b50624198d!8m2!3d39.7700573!4d-86.1469668",
            appleMap: "http://maps.apple.com/?daddr=600+E+Ohio+Street,Indianapolis,IN,46202&dirflg=d&t=h",
            mondayOpen: 1600,
            mondayClose: 2200,
            tuesdayOpen: 1600,
            tuesdayClose: 2200,
            wednesdayOpen: 1600,
            wednesdayClose: 2200,
            thursdayOpen: 1600,
            thursdayClose: 2200,
            fridayOpen: 1600,
            fridayClose: 2359,
            saturdayOpen: 1200,
            saturdayClose: 2359,
            sundayOpen: 1200,
            sundayClose: 2000,
            isOpen: false,
            isFave: false
        )
        
        let shop25 = CoffeeShop(
            name: "The Haverstick",
            neighborhood: "Keystone",
            long: 39.920388,
            lat: -86.114904,
            listBrew: "Brickhouse Coffee",
            listSpace: "The biggest, most comfortable space inside Church at the Crossing.",
            feature: featHaverstick!,
            newShop: false,
            igHandle: "thehaverstick",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.920388, longitude: -86.114904)))*0.000621371,
            googleMap: "www.google.com/maps/place/The+Haverstick/@39.9203427,-86.1171034,17z/data=!3m1!4b1!4m5!3m4!1s0x8814ad35c12ab891:0xb9d2095505a01201!8m2!3d39.9203386!4d-86.1149147",
            appleMap: "http://maps.apple.com/?daddr=9111+Haverstick+Road,Indianapolis,IN,46240&dirflg=d&t=h",
            mondayOpen: 0800,
            mondayClose: 1800,
            tuesdayOpen: 0800,
            tuesdayClose: 1800,
            wednesdayOpen: 0800,
            wednesdayClose: 1800,
            thursdayOpen: 0800,
            thursdayClose: 1800,
            fridayOpen: 0800,
            fridayClose: 1800,
            saturdayOpen: 000,
            saturdayClose: 000,
            sundayOpen: 000,
            sundayClose: 000,
            isOpen: false,
            isFave: false
        )
        
        let shop26 = CoffeeShop(
            name: "Della Leva",
            neighborhood: "Fishers",
            long: 39.941175,
            lat: -86.022955,
            listBrew: "Della Leva Blends",
            listSpace: "Europe meets Chicago meets Indy.",
            feature: featDellaLava!,
            newShop: false,
            igHandle: "dellalava",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.941175, longitude: -86.022955)))*0.000621371,
            googleMap: "www.google.com/maps/place/Della+Leva+Espresso+Bar/@39.9411734,-86.025146,17z/data=!3m1!4b1!4m5!3m4!1s0x8814b36e54179c1f:0xfdacbb5e1c64606a!8m2!3d39.9411693!4d-86.0229573",
            appleMap: "http://maps.apple.com/?daddr=8220+E+106+St,Fishers,IN,46256&dirflg=d&t=h",
            mondayOpen: 0600,
            mondayClose: 1900,
            tuesdayOpen: 0600,
            tuesdayClose: 1900,
            wednesdayOpen: 0600,
            wednesdayClose: 1900,
            thursdayOpen: 0600,
            thursdayClose: 1900,
            fridayOpen: 0600,
            fridayClose: 1900,
            saturdayOpen: 0900,
            saturdayClose: 1700,
            sundayOpen: 0900,
            sundayClose: 1500,
            isOpen: false,
            isFave: false
        )
        
        let shop27 = CoffeeShop(
            name: "SoHo Cafe & Gallery",
            neighborhood: "Carmel",
            long: 39.972286,
            lat: -86.129280,
            listBrew: "Counter Culture",
            listSpace: "Local coffee shop with plenty of space and local food & gifts.",
            feature: featSoHo!,
            newShop: false,
            igHandle: "soho_cafe",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.972286, longitude: -86.129280)))*0.000621371,
            googleMap: "www.google.com/maps/place/SoHo+Cafe+%26+Gallery/@39.972265,-86.1314685,17z/data=!3m1!4b1!4m5!3m4!1s0x8814adb141e2ac75:0x52ac3a039af8d0ea!8m2!3d39.9722609!4d-86.1292798",
            appleMap: "http://maps.apple.com/?daddr=620+S+Rangeline+Rd,Carmel,IN,46032&dirflg=d&t=h",
            mondayOpen: 0700,
            mondayClose: 1700,
            tuesdayOpen: 0700,
            tuesdayClose: 1700,
            wednesdayOpen: 0700,
            wednesdayClose: 1700,
            thursdayOpen: 0700,
            thursdayClose: 1700,
            fridayOpen: 0700,
            fridayClose: 1700,
            saturdayOpen: 0700,
            saturdayClose: 1700,
            sundayOpen: 1000,
            sundayClose: 1600,
            isOpen: false,
            isFave: false
        )
        
        let shop28 = CoffeeShop(
            name: "Hubbard & Cravens - Broad Ripple",
            neighborhood: "Broad Ripple",
            long: 39.868740,
            lat: -86.144594,
            listBrew: "Hubbard & Cravens Coffee",
            listSpace: "When you think 'coffee house,' this is the place that comes to mind. FRIENDS vibes with great coffee.",
            feature: featHubbardBroad!,
            newShop: false,
            igHandle: "hubbardandcravens",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.8687379, longitude: -86.1467892)))*0.000621371,
            googleMap: "www.google.com/maps/place/Hubbard+%26+Cravens+Coffee/@39.8687379,-86.1467892,17z/data=!3m1!4b1!4m5!3m4!1s0x886b53af7e2dd9f7:0xe30c306672c9f3db!8m2!3d39.8687379!4d-86.1445952",
            appleMap: "http://maps.apple.com/?daddr=6229+Carrollton+Ave,Indianapolis,IN,46220&dirflg=d&t=h",
            mondayOpen: 0630,
            mondayClose: 1800,
            tuesdayOpen: 0630,
            tuesdayClose: 1800,
            wednesdayOpen: 0630,
            wednesdayClose: 1800,
            thursdayOpen: 0630,
            thursdayClose: 1800,
            fridayOpen: 0630,
            fridayClose: 1800,
            saturdayOpen: 0630,
            saturdayClose: 1800,
            sundayOpen: 0700,
            sundayClose: 1500,
            isOpen: false,
            isFave: false
        )
        
        let shop29 = CoffeeShop(
            name: "Coffeehouse Five",
            neighborhood: "Greenwood",
            long: 39.612217,
            lat: -86.110510,
            listBrew: "Coffeehouse Five Coffee",
            listSpace: "Greenwood's best kept secret. The coffee is great, the food is amazing, and the community is compassionate.",
            feature: featCoffeehouseFive!,
            newShop: false,
            igHandle: "coffeehouse_five",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.612217, longitude: -86.110510)))*0.000621371,
            googleMap: "www.google.com/maps/place/Coffeehouse+Five/@39.6122108,-86.112704,17z/data=!3m1!4b1!4m5!3m4!1s0x886b5dbca29b7c4f:0x75f2589f7b27edd7!8m2!3d39.6122108!4d-86.11051",
            appleMap: "http://maps.apple.com/?daddr=323+Market+Plaza,Greenwood,IN,46142&dirflg=d&t=h",
            mondayOpen: 0730,
            mondayClose: 1630,
            tuesdayOpen: 0730,
            tuesdayClose: 1630,
            wednesdayOpen: 0730,
            wednesdayClose: 1630,
            thursdayOpen: 0730,
            thursdayClose: 1630,
            fridayOpen: 0730,
            fridayClose: 1630,
            saturdayOpen: 0730,
            saturdayClose: 1300,
            sundayOpen: 0000,
            sundayClose: 0000,
            isOpen: false,
            isFave: false
        )
        
        
        let shop30 = CoffeeShop(
            name: "P R O V I D E R",
            neighborhood: "Downtown",
            long: 39.787991,
            lat: -86.139434,
            listBrew: "Ruby Roasters & Tinker Coffee",
            listSpace: "Coffee & Long Drinks in the Tinker House Event Space. Coat Check's older, cooler brother.",
            feature: featProvider!,
            newShop: false,
            igHandle: "providerindy",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.787991, longitude: -86.139434)))*0.000621371,
            googleMap: "www.google.com/maps/place/P+R+O+V+I+D+E+R+Coffee/@39.7879854,-86.1416292,17z/data=!3m1!4b1!4m5!3m4!1s0x886b51fc83ebf6af:0xc1e63441facdde88!8m2!3d39.7879854!4d-86.1394405",
            appleMap: "http://maps.apple.com/?daddr=1101+E+16th+Street,Indianapolis,IN,46202&dirflg=d&t=h",
            mondayOpen: 0700,
            mondayClose: 2200,
            tuesdayOpen: 0700,
            tuesdayClose: 2200,
            wednesdayOpen: 0700,
            wednesdayClose: 2200,
            thursdayOpen: 0700,
            thursdayClose: 2200,
            fridayOpen: 0700,
            fridayClose: 2300,
            saturdayOpen: 0800,
            saturdayClose: 1800,
            sundayOpen: 0800,
            sundayClose: 2200,
            isOpen: false,
            isFave: false
        )
        
        
        
        let shop31 = CoffeeShop(
            name: "Square Cat Vinyl",
            neighborhood: "Fountain Square",
            long: 39.752780,
            lat: -86.140364,
            listBrew: "Tinker Coffee",
            listSpace: "Half killer coffee shop, half vinyl record store. Does it get better?",
            feature: featSquareCat!,
            newShop: false,
            igHandle: "squarecatvinyl",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.752780, longitude: -86.140364)))*0.000621371,
            googleMap: "www.google.com/maps/place/Square+Cat+Vinyl/@39.7527784,-86.1425536,17z/data=!3m1!4b1!4m5!3m4!1s0x886b5a78a784033b:0x3f6b8d6a03de2556!8m2!3d39.7527784!4d-86.1403649",
            appleMap: "http://maps.apple.com/?daddr=1054+Virginia+Avenue,Indianapolis,IN,46203&dirflg=d&t=h",
            mondayOpen: 0800,
            mondayClose: 2200,
            tuesdayOpen: 0800,
            tuesdayClose: 2200,
            wednesdayOpen: 0800,
            wednesdayClose: 2200,
            thursdayOpen: 0800,
            thursdayClose: 2200,
            fridayOpen: 0800,
            fridayClose: 2359,
            saturdayOpen: 0900,
            saturdayClose: 2359,
            sundayOpen: 1100,
            sundayClose: 1900,
            isOpen: false,
            isFave: false
        )
        
        let shop32 = CoffeeShop(
            name: "Porter Books & Bread",
            neighborhood: "Lawrence",
            long: 39.857898,
            lat: -86.013075,
            listBrew: "Roasted in house.",
            listSpace: "Indy's best kept secret THAT SHOULDN'T BE A SECRET ANYMORE.",
            feature: featPorter!,
            newShop: false,
            igHandle: "porterbooksandbread",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.857898, longitude: -86.013075)))*0.000621371,
            googleMap: "www.google.com/maps/place/Porter+Books+and+Bread/@39.8578972,-86.0152651,17z/data=!3m1!4b1!4m5!3m4!1s0x886b4c763e5589af:0xd041b4815a5b6072!8m2!3d39.8578972!4d-86.0130764",
            appleMap: "http://maps.apple.com/?daddr=5719+Lawton+Loop+E+Dr,Indianapolis,IN,46216&dirflg=d&t=h",
            mondayOpen: 0600,
            mondayClose: 1600,
            tuesdayOpen: 0600,
            tuesdayClose: 1600,
            wednesdayOpen: 0600,
            wednesdayClose: 1600,
            thursdayOpen: 0600,
            thursdayClose: 1600,
            fridayOpen: 0600,
            fridayClose: 1800,
            saturdayOpen: 0800,
            saturdayClose: 1800,
            sundayOpen: 0000,
            sundayClose:0000,
            isOpen: false,
            isFave: false
        )
        
        let shop33 = CoffeeShop(
            name: "Commissary Barber & Barista",
            neighborhood: "Downtown",
            long: 39.771395,
            lat: -86.1522505,
            listBrew: "Tinker Coffee",
            listSpace: "Half kick-ass barbershop, Half amazing coffee shop. What else do you need?",
            feature: featCommissary!,
            newShop: false,
            igHandle: "commissaryindy",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.771395, longitude:  -86.152250)))*0.000621371,
            googleMap: "www.google.com/maps/place/Commissary+Barber+%26+Barista/@39.7713922,-86.1544407,17z/data=!3m1!4b1!4m5!3m4!1s0x886b51a28fe3a259:0xe2b149ea775ac363!8m2!3d39.7713922!4d-86.152252",
            appleMap: "http://maps.apple.com/?daddr=304+E+New+York+St,Indianapolis,IN,46204&dirflg=d&t=h",
            mondayOpen: 0730,
            mondayClose: 1900,
            tuesdayOpen: 0730,
            tuesdayClose: 1900,
            wednesdayOpen: 0730,
            wednesdayClose: 1900,
            thursdayOpen: 0730,
            thursdayClose: 1900,
            fridayOpen: 0730,
            fridayClose: 1900,
            saturdayOpen: 0800,
            saturdayClose: 1900,
            sundayOpen: 0900,
            sundayClose:1800,
            isOpen: false,
            isFave: false
        )
        
        let shop34 = CoffeeShop(
            name: "Cafe Mansion",
            neighborhood: "Downtown",
            long: 39.767862,
            lat: -86.211162,
            listBrew: "Tinker Coffee & Intelligentsia",
            listSpace: "The COOLEST cafe in the lobby of Central State Mansion with serious retro vibes.",
            feature: featMansion!,
            newShop: true,
            igHandle: "cafemansion",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.767862, longitude:  -86.211162)))*0.000621371,
            googleMap: "www.google.com/maps/place/Caf%C3%A9+Mansi%C3%B3n/@39.767857,-86.2133497,17z/data=!3m1!4b1!4m5!3m4!1s0x886b5787fb54af1f:0xa50cb7c3340ce5b0!8m2!3d39.767857!4d-86.211161",
            appleMap: "http://maps.apple.com/?daddr=202+Steeples+Blvd,Indianapolis,IN,46222&dirflg=d&t=h",
            mondayOpen: 0000,
            mondayClose: 0000,
            tuesdayOpen: 0700,
            tuesdayClose: 1900,
            wednesdayOpen: 0700,
            wednesdayClose: 1900,
            thursdayOpen: 0700,
            thursdayClose: 1900,
            fridayOpen: 0700,
            fridayClose: 1900,
            saturdayOpen: 0800,
            saturdayClose: 1800,
            sundayOpen: 0800,
            sundayClose:1800,
            isOpen: false,
            isFave: false
        )
        
        let shop35 = CoffeeShop(
            name: "Gavel",
            neighborhood: "Fountain Square",
            long: 39.767862,
            lat: -86.211162,
            listBrew: "Tinker Coffee",
            listSpace: "An old courtroom turned lobby of a marketing agency. Somewhere between a coffee shop and a cocktail bar.",
            feature: featGavel!,
            newShop: true,
            igHandle: "gavel.indy",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.7546719, longitude:  -86.1422789)))*0.000621371,
            googleMap: "www.google.com/maps/place/Gavel/@39.754702,-86.1421245,15z/data=!4m5!3m4!1s0x0:0xcd9368583dbde10e!8m2!3d39.754702!4d-86.1421245",
            appleMap: "http://maps.apple.com/?daddr=902+Virgina+Ave,Indianapolis,IN,46203&dirflg=d&t=h",
            mondayOpen: 0800,
            mondayClose: 1830,
            tuesdayOpen: 0800,
            tuesdayClose: 1830,
            wednesdayOpen: 0800,
            wednesdayClose: 1830,
            thursdayOpen: 0800,
            thursdayClose: 1830,
            fridayOpen: 0800,
            fridayClose: 1830,
            saturdayOpen: 0800,
            saturdayClose: 1830,
            sundayOpen: 0800,
            sundayClose:1830,
            isOpen: false,
            isFave: false
        )
        
        let shop36 = CoffeeShop(
            name: "Porter Coffee",
            neighborhood: "Greenfield",
            long: 39.767862,
            lat: -86.211162,
            listBrew: "Roasted in house!",
            listSpace: "Beautiful space that always smells like coffee and cookies. It's...heaven.",
            feature: featPorterCoffee!,
            newShop: true,
            igHandle: "portercoffeeindy",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.7854673, longitude: -85.7714191)))*0.000621371,
            googleMap: "www.google.com/maps/place/Porter+Coffee/@39.7854673,-85.7714191,17z/data=!3m1!4b1!4m5!3m4!1s0x886b33eb42d4455b:0xf31d8ba90b6bcbd!8m2!3d39.834822!4d-85.770607",
            appleMap: "http://maps.apple.com/?daddr=9+N+State+St,Greenfield,IN,46140&dirflg=d&t=h",
            mondayOpen: 0000,
            mondayClose: 0000,
            tuesdayOpen: 0730,
            tuesdayClose: 1400,
            wednesdayOpen: 0730,
            wednesdayClose: 1400,
            thursdayOpen: 0730,
            thursdayClose: 1400,
            fridayOpen: 0730,
            fridayClose: 1400,
            saturdayOpen: 0900,
            saturdayClose: 1500,
            sundayOpen: 0000,
            sundayClose:0000,
            isOpen: false,
            isFave: false
        )
        
        let shop37 = CoffeeShop(
            name: "The Greenfield Grind",
            neighborhood: "Greenfield",
            long: 39.767862,
            lat: -86.211162,
            listBrew: "Blue Mind Roasting",
            listSpace: "Bright, fun, beautiful space that is exactly where you want to be.",
            feature: featGreenfieldGrind!,
            newShop: true,
            igHandle: "thegreenfieldgrind",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.7856421, longitude: -85.7716659)))*0.000621371,
            googleMap: "www.google.com/maps/place/The+Greenfield+Grind/@39.7856421,-85.7716659,17z/data=!3m1!4b1!4m5!3m4!1s0x886b31d42c34b6c1:0x9c7165505395f3a!8m2!3d39.7856421!4d-85.7694772",
            appleMap: "http://maps.apple.com/?daddr=14+N+State+St,Greenfield,IN,46140&dirflg=d&t=h",
            mondayOpen: 0700,
            mondayClose: 1500,
            tuesdayOpen: 0700,
            tuesdayClose: 1500,
            wednesdayOpen: 0700,
            wednesdayClose: 1500,
            thursdayOpen: 0700,
            thursdayClose: 1500,
            fridayOpen: 0700,
            fridayClose: 1500,
            saturdayOpen: 0800,
            saturdayClose: 1500,
            sundayOpen: 0000,
            sundayClose:0000,
            isOpen: false,
            isFave: false
        )
        
        let shop38 = CoffeeShop(
            name: "Nine Lives Cat Cafe",
            neighborhood: "Fountain Square",
            long: 39.767862,
            lat: -86.211162,
            listBrew: "Brickhouse Coffee",
            listSpace: "CATS. THERE'S NOTHING ELSE YOU NEED TO KNOW.",
            feature: featNineLives!,
            newShop: false,
            igHandle: "ninelivesindy",
            distance: (userLocale.distance(from: CLLocation(latitude: 39.7497066, longitude: -86.141839)))*0.000621371,
            googleMap: "www.google.com/maps/place/Nine+Lives+Cat+Café/@39.7497066,-86.141839,17z/data=!3m1!4b1!4m5!3m4!1s0x886b5a792d1e37ef:0x353d099e147fba54!8m2!3d39.7497066!4d-86.1396503",
            appleMap: "http://maps.apple.com/?daddr=1315+Shelby+St,Indianapolis,IN,46203&dirflg=d&t=h",
            mondayOpen: 0700,
            mondayClose: 1500,
            tuesdayOpen: 0700,
            tuesdayClose: 1500,
            wednesdayOpen: 0700,
            wednesdayClose: 1500,
            thursdayOpen: 0700,
            thursdayClose: 1500,
            fridayOpen: 0700,
            fridayClose: 1500,
            saturdayOpen: 0800,
            saturdayClose: 1500,
            sundayOpen: 0000,
            sundayClose:0000,
            isOpen: false,
            isFave: false
        )

        
        
        shops += [shop1, shop2, shop3, shop5, shop6, shop7, shop9, shop10, shop11, shop12, shop13, shop16, shop17, shop19, shop20, shop21, shop22, shop23, shop24, shop25, shop26, shop27, shop28, shop29, shop30, shop31, shop32, shop33, shop34, shop35, shop36, shop37, shop38]
        
        
        
        
    }
    
    
    
    
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        
            
        if segue.identifier == "showDetail" {
            guard let shopDetailViewController = segue.destination as? ShopDetail
                else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedShopCell = sender as? CoffeeShopTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedShopCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let shop = shops[indexPath.row]
            shopDetailViewController.detailShop = shop
        }
        
    }
    
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    
    
    
    @objc func handleRefresh() {
        
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
