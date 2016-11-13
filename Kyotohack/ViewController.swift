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


        let obj = NCMBQuery(className: "professor")
        obj?.whereKey("name", equalTo: "田島孝治")
        obj?.findObjectsInBackground({(objects, error) in
            if (error == nil) {
                if((objects?.count)! > 0)
                {
                    let ob = objects!.first as! NCMBObject
                    self.oid = ob.objectId!
                    print(ob)

                }
            } else {

            }


        })


        let obj1 = NCMBObject(className: "TestClass")
        // 値を設定
        obj1?.setObject("Hello,NCMB!", forKey: "message")
        // 保存を実施
        obj1?.saveInBackground({(error) in
        if (error != nil) {
                // 保存に失敗した場合の処理
        }else{
                // 保存に成功した場合の処理

        }
        })

    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.locationManerger.startRangingBeacons(in: self.myRegion)

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

            print(beacons)

    }





    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        self.locationManerger.stopRangingBeacons(in: self.myRegion)
    }



}

