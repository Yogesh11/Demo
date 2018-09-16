//
//  ViewController.swift
//  Demo
//
//  Created by Yogesh on 8/28/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import SVProgressHUD
class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listModel.facilityStorage.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell?.textLabel?.text  =  listModel.facilityStorage[indexPath.row].name
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dropDownController =  self.storyboard?.instantiateViewController(withIdentifier: "DropDownController") as! DropDownController
        let facility = listModel.facilityStorage[indexPath.row]
        dropDownController.faciltyID    = facility.facilityId
        dropDownController.selectedID   = facility.answerId
        self.navigationController?.pushViewController(dropDownController, animated: true)
    }

    @IBOutlet var tableLayout: UITableView!
    private var listModel  : FacilityViewModel = FacilityViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
        tableLayout.delegate = self
        tableLayout.dataSource = self

        listModel.getData { (json, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.tableLayout.reloadData()
                } else{
                    self.showAlert(error: error!)
                }
                SVProgressHUD.dismiss()
            }
        }
        self.tableLayout.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.title = "Facilities"
    }

    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
         self.title = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func showAlert(error : RError){
       let alertController =  UIAlertController(title: error.errortitle, message: error.errorMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { (alertAction) in

        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

