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

class ViewController: UIViewController,CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var TableView: UITableView!
    
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
    
    var name:[String] = []
    var num:[String] = []
    var time:[String] = []
    var oids:[String] = []

   
    let app = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TableView.delegate = self
        self.TableView.dataSource = self
        
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
        obj1?.whereKey("professorID", equalTo:"e6R22IS181UOMhx2")
        obj1?.findObjectsInBackground({(objects , error) in
            if (error == nil) {
                if((objects?.count)! > 0)
                {
                    for ob in (objects! as? [NCMBObject])! {
                        print(ob)
                        self.name.append(ob.object(forKey: "name") as! String!)
                        self.num.append(ob.object(forKey: "studentID") as! String!)
                        self.time.append("2016-11-13-08:11:45")
                        
                    }
                    
                }
            } else {
                
            }
            self.TableView.reloadData()
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

        self.name.removeAll()
        self.num.removeAll()
        self.time.removeAll()
        self.oids.removeAll()
        
        let obj = NCMBQuery(className: "Appointment")
        obj?.whereKey("professorID", equalTo:"e6R22IS181UOMhx2")
        obj?.findObjectsInBackground({(objects , error) in
            if (error == nil) {
                if((objects?.count)! > 0)
                {
                    for ob in (objects! as? [NCMBObject])! {
                        print(ob)
                        self.name.append(ob.object(forKey: "name") as! String!)
                        self.num.append(ob.object(forKey: "studentID") as! String!)
                        self.time.append(String(describing: ob.createDate!))
                        self.oids.append(ob.objectId)
                    
                }
                    
                }
            } else {
                
            }
            self.TableView.reloadData()
        })

        
        
        
        if beacons.count == 0 {

            let obj1 = NCMBObject(className: "Professor")
            obj1?.objectId = "e6R22IS181UOMhx2"
            // 値を設定
            obj1?.setObject(false, forKey: "presence")
            // 保存を実施
            obj1?.saveInBackground({(error) in
                if (error != nil) {
                    // 保存に失敗した場合の処理
                }else{
                    // 保存に成功した場合の処理
                }
            })


        }else{
            let obj1 = NCMBObject(className: "Professor")
            obj1?.objectId = "e6R22IS181UOMhx2"
            // 値を設定
            obj1?.setObject(true, forKey: "presence")
            // 保存を実施
            obj1?.saveInBackground({(error) in
                if (error != nil) {
                    // 保存に失敗した場合の処理
                }else{
                    // 保存に成功した場合の処理
                }
            })

        }



    }

    @IBOutlet weak var busyToggle: UISwitch!
    
    @IBAction func changed(_ sender: UISwitch) {
        let obj1 = NCMBObject(className: "Professor")
        obj1?.objectId = "e6R22IS181UOMhx2"
        if busyToggle.isOn {
            // 値を設定
            obj1?.setObject(true, forKey: "busy")
            // 保存を実施
            obj1?.saveInBackground({(error) in
                if (error != nil) {
                    // 保存に失敗した場合の処理
                }else{
                    // 保存に成功した場合の処理
                }
            })
        } else {
            obj1?.setObject(false, forKey: "busy")
            // 保存を実施
            obj1?.saveInBackground({(error) in
                if (error != nil) {
                    // 保存に失敗した場合の処理
                }else{
                    // 保存に成功した場合の処理
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! TableViewCell
        
        cell.name.text = self.name[indexPath.row]
        cell.date.text = self.time[indexPath.row]
        cell.number.text = self.num[indexPath.row]
        
        
        return cell
    }

    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        self.locationManerger.stopRangingBeacons(in: self.myRegion)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! TableViewCell
        
        let obj1 = NCMBObject(className: "Appointment1")
            // 値を設定
            obj1?.setObject(true, forKey: "approval")
            // 保存を実施
            obj1?.saveInBackground({(error) in
                if (error != nil) {
                    // 保存に失敗した場合の処理
                }else{
                    // 保存に成功した場合の処理
                }
            })

        
    }

}

