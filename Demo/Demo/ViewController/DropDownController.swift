//
//  DropDownController.swift
//  Demo
//
//  Created by Yogesh on 9/16/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class DropDownController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableLayout: UITableView!
    var faciltyID : String!
    var selectedID : String?
    private var options : [Option] = [Option]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constant.K_CellID.k_cellID)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: Constant.K_CellID.k_cellID)
        }
        let option = options[indexPath.row]
        cell?.imageView?.image = UIImage(named: option.icon ?? "")
        cell?.textLabel?.text  = option.name
        cell?.accessoryType = option.facilityId == faciltyID && option.id == selectedID  ? .checkmark : .none
        cell?.backgroundColor =  option.isEnable ? .clear : .gray
        cell?.isUserInteractionEnabled = option.isEnable
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         let option = options[indexPath.row]
         if option.isEnable {
            if let optionID = option.id {
                DataBaseManager.sharedManager.saveAnswer(facilityID : faciltyID , answerID : optionID)
            }
            navigationController?.popToRootViewController(animated: true)
         } else{
            print("Oops disable field.")
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableLayout.delegate = self
        tableLayout.dataSource = self
        options = DataBaseManager.sharedManager.getOptionsBy(facilityID: faciltyID)
        self.title = Constant.K_ViewTitle.k_Option
        self.navigationItem.backBarButtonItem?.title = Constant.K_ViewTitle.k_Empty
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
