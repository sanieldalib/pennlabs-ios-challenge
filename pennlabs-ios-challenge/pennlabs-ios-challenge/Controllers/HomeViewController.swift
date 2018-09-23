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
    let refresh = UIRefreshControl()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Networking.getData {
            self.diningData.loadData(data: Networking.venues)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refresh
        refresh.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refresh.tintColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func refreshData (_ sender: Any) {
        Networking.getData {
            self.diningData.loadData(data: Networking.venues)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refresh.endRefreshing()
            }
        }
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
        cell.statusLabel.textColor = .statusColor
        if indexPath.section == 0 {
            
            if diningData.diningHalls[indexPath.row].status == .OPEN{
                cell.statusLabel.textColor = .openColor
            }
            
            cell.diningName?.text = diningData.diningHalls[indexPath.row].name
            cell.diningImage.image = diningData.diningHalls[indexPath.row].image
            cell.statusLabel.text = diningData.diningHalls[indexPath.row].status.rawValue
            cell.hoursLabel.text = diningData.diningHalls[indexPath.row].hourString
        } else {
            if diningData.retailDining[indexPath.row].status == .OPEN{
                cell.statusLabel.textColor = .openColor
            }
            
            cell.diningName?.text = diningData.retailDining[indexPath.row].name
            cell.diningImage.image = diningData.retailDining[indexPath.row].image
            cell.statusLabel.text = diningData.retailDining[indexPath.row].status.rawValue
            cell.hoursLabel.text = diningData.retailDining[indexPath.row].hourString
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? diningData.diningHalls.count : diningData.retailDining.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebView"{
            if let webVC = segue.destination as? WebViewController{
                if let index = tableView.indexPathForSelectedRow{
                    webVC.diningURL = index.section == 0 ? diningData.diningHalls[index.row].url : diningData.retailDining[index.row].url
                    webVC.title = index.section == 0 ? diningData.diningHalls[index.row].name : diningData.retailDining[index.row].name
                }
            }
        }
    }
    



}

