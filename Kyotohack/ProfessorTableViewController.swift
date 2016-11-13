//
//  ProfessorTableViewController.swift
//  Kyotohack
//
//  Created by Tomoki Nishinaka on 2016/11/13.
//  Copyright © 2016年 Tomoki Nishinaka. All rights reserved.
//

import UIKit
import NCMB
import Kingfisher

class Professor_enable_TableViewController: UITableViewController {

    var professor:[Professor] = []
    var pro:Professor!
    let app = UIApplication.shared.delegate as! AppDelegate
    var name:[String] = []
    var imageurl:[String] = []
    var roomname:[String] = []
    var oid:[String] = []


    func refresh()
    {
        let obj = NCMBQuery(className: "Professor")
        obj?.whereKey("presence", equalTo: true)
        obj?.findObjectsInBackground({(objects , error) in
            if (error == nil) {
                if((objects?.count)! > 0)
                {
                    for ob in (objects! as? [NCMBObject])! {
                        print(ob)
                        self.name.append(ob.object(forKey: "name") as! String!)
                        self.imageurl.append(ob.object(forKey: "imageUrl") as! String!)
                        self.roomname.append(ob.object(forKey: "room") as! String!)
                        self.oid.append(ob.objectId)
                    }

                }
            } else {

            }
            
        })

    }

    override func viewDidLoad() {

        super.viewDidLoad()


       


        let obj = NCMBQuery(className: "Professor")
        obj?.whereKey("presence", equalTo: true)
        obj?.findObjectsInBackground({(objects , error) in
            if (error == nil) {
                if((objects?.count)! > 0)
                {
                    for ob in (objects! as? [NCMBObject])! {
                        print(ob)
                        self.name.append(ob.object(forKey: "name") as! String!)
                        self.imageurl.append(ob.object(forKey: "imageUrl") as! String!)
                        self.roomname.append(ob.object(forKey: "room") as! String!)
                        self.oid.append(ob.objectId)
                    }

                }
            } else {

            }

        })

    }

    override func viewDidAppear(_ animated: Bool) {
        self.name
        self.imageurl.append(ob.object(forKey: "imageUrl") as! String!)
        self.roomname.append(ob.object(forKey: "room") as! String!)
        self.oid.append(ob.objectId)


        let obj = NCMBQuery(className: "Professor")
        obj?.whereKey("presence", equalTo: true)
        obj?.findObjectsInBackground({(objects , error) in
            if (error == nil) {
                if((objects?.count)! > 0)
                {
                    for ob in (objects! as? [NCMBObject])! {
                        print(ob)
                        self.name.append(ob.object(forKey: "name") as! String!)
                        self.imageurl.append(ob.object(forKey: "imageUrl") as! String!)
                        self.roomname.append(ob.object(forKey: "room") as! String!)
                        self.oid.append(ob.objectId)
                    }

                }
            } else {

            }
            
        })
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return name.count


    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell:ProfessorTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProfessorTableViewCell
        cell.images.kf.setImage(with: URL(string: imageurl[indexPath.row]))
        cell.name.text = name[indexPath.row]
        cell.room.text = roomname[indexPath.row]
        // Configure the cell...

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        app.oid = self.oid[indexPath.row]

        let nex = self.storyboard!.instantiateViewController(withIdentifier: "form")
        self.present(nex , animated: true, completion: nil)

        
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

}
