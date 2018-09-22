//
//  ViewController.swift
//  pennlabs-ios-challenge
//
//  Created by Daniel Salib on 9/22/18.
//  Copyright © 2018 dsalib. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var diningData = tableViewModel()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Setting headers with custom view from nib
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = Bundle.main.loadNibNamed("headerCell", owner: self, options: nil)?.first as! headerCell
        headerCell.headerTitle.text = section == 0 ? "Dining Halls" : "Retail Dining"
        return headerCell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    //end custom headers
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "diningHallCell") as! diningHallCell
        if indexPath.section == 0 {
            cell.diningName?.text = diningData.diningHalls[indexPath.row].name
            cell.diningImage.image = diningData.diningHalls[indexPath.row].image
        } else {
            cell.diningName?.text = diningData.retailDining[indexPath.row].name
            cell.diningImage.image = diningData.retailDining[indexPath.row].image
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? diningData.diningHalls.count : diningData.retailDining.count
    }
    



}

