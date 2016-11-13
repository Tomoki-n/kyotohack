//
//  ViewController.swift
//  Kyotohack
//
//  Created by Tomoki Nishinaka on 2016/11/13.
//  Copyright © 2016年 Tomoki Nishinaka. All rights reserved.
//

import UIKit
import CoreLocation
import NCMB
import UserNotifications

class ViewController: UIViewController,CLLocationManagerDelegate {

    var locationManerger:CLLocationManager!
    var myUUID:NSUUID!
    var selectUUID:NSUUID!
    var myRegion:CLBeaconRegion!
    var selectBeacon:CLBeacon!

    var id = 0
    var before_id = 0
    var b_count = 0
    var boss = false
    var oid = ""

    let app = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myUUID = NSUUID(uuidString: "00000000-88F6-1001-B000-001C4D2D20E6")
        self.myRegion = CLBeaconRegion(proximityUUID: self.myUUID as UUID, identifier: self.myUUID.uuidString)
        self.locationManerger = CLLocationManager()
        self.locationManerger.delegate = self
        self.locationManerger.requestWhenInUseAuthorization()
        self.locationManerger.startRangingBeacons(in: self.myRegion)


        // Do any additional setup after loading the view, typically from a nib.


        let obj = NCMBQuery(className: "Professor")
        obj?.whereKey("busy", equalTo: true)
        obj?.findObjectsInBackground({(objects, error) in
            if (error == nil) {
                if((objects?.count)! > 0)
                {
                    let ob = objects!.first as! NCMBObject
                    self.oid = ob.objectId!
                    print(objects!)
                }
            } else {

            }
        })


        let obj1 = NCMBQuery(className: "Appointment")
        obj1?.findObjectsInBackground({(objects , error) in
            if (error == nil) {
                if((objects?.count)! > 0)
                {
                    self.b_count = (objects?.count)!


                }
            } else {

            }
            
        })
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.locationManerger.startRangingBeacons(in: self.myRegion)
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        }

    }

    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            self.locationManerger.startRangingBeacons(in: self.myRegion)
            break
        default:
            print("許可がありません\n")
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("iPad did Enter Region")
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("iPad did Exit Region")
    }

    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {

        
         let obj = NCMBQuery(className: "Appointment1")
        obj?.findObjectsInBackground({(objects , error) in
            if (error == nil) {
                if((objects?.count)! > self.b_count)
                {

                    let content = UNMutableNotificationContent()

                    content.title = "確認"
                    content.body = "井佐原 均から承認されました。"
                    content.sound = UNNotificationSound.default()

                    // Deliver the notification in five seconds.
                    let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
                    let request = UNNotificationRequest.init(identifier: "FiveSecond", content: content, trigger: trigger)

                    // Schedule the notification.
                    let center = UNUserNotificationCenter.current()
                    center.add(request) { (error) in
                        print(error)
                    }
                    print("should have been added")

                }
            } else {

            }
            
        })



    }


    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        self.locationManerger.stopRangingBeacons(in: self.myRegion)
    }



}

