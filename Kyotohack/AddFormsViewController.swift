//
//  AddFormsViewController.swift
//  Kyotohack
//
//  Created by Tomoki Nishinaka on 2016/11/13.
//  Copyright © 2016年 Tomoki Nishinaka. All rights reserved.
//

import UIKit
import NCMB

class AddFormsViewController: UIViewController {

     @IBOutlet weak var textField: UITextField!
     @IBOutlet weak var textField2: UITextField!


    @IBOutlet weak var fiekd: UITextView!

    let app = UIApplication.shared.delegate as! AppDelegate



    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //非表示にする。
        if(textField.isFirstResponder||textField2.isFirstResponder||fiekd.isFirstResponder){
            textField.resignFirstResponder()
            textField2.resignFirstResponder()
            fiekd.resignFirstResponder()
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()



        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(_ sender: Any) {


        let obj1 = NCMBObject(className: "Appointment")
        // 値を設定
        obj1?.setObject(textField.text, forKey: "name")
        obj1?.setObject(textField2.text, forKey: "studentID")
        obj1?.setObject(fiekd.text, forKey: "content")
        obj1?.setObject(self.app.oid, forKey:"professorID")

        // 保存を実施
        obj1?.saveInBackground({(error) in
            if (error != nil) {
                // 保存に失敗した場合の処理
            }else{
                // 保存に成功した場合の処理
                self.dismiss(animated: true, completion: nil)

            }
        })


    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
