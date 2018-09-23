//
//  ViewController.swift
//  pennlabs-ios-challenge
//
//  Created by Daniel Salib on 9/22/18.
//  Copyright © 2018 dsalib. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var diningData = tableViewModel()
    let refresh = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Networking.getData(completion: {
            //successful data callback
            self.diningData.loadData(data: Networking.venues, completed: {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }) {
            //error callback
            self.diningData.loadDefaults()
            DispatchQueue.main.async {
                self.tableView.reloadData()
                //alerts the user that there an error occurred
                let banner = NotificationBanner(title: "Check your internet connection", style: .danger)
                banner.show()
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
    }
    
    @objc func refreshData (_ sender: Any) {
        Networking.getData(completion: {
            //successful data callback
            self.diningData.loadData(data: Networking.venues, completed: {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refresh.endRefreshing()
                }
            })
        }) {
            //error callback
            DispatchQueue.main.async {
                self.refresh.endRefreshing()
                let banner = NotificationBanner(title: "Check your internet connection", style: .danger)
                banner.show()
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
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        //check to see if that specific dining hall has a url before segue - If JSON decoder errors then URL is nil
        if identifier == "toWebView"{
            if let index = tableView.indexPathForSelectedRow{
                let diningHall = index.section == 0 ? diningData.diningHalls[index.row] : diningData.retailDining[index.row]
                if diningHall.url == nil {
                    //error banner is thrown if no URL is found
                    let banner = NotificationBanner(title: "An error occured.", subtitle: "Check your internet connection", style: .danger)
                    banner.show()
                    return false
                }
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebView"{
            if let webVC = segue.destination as? WebViewController{
                if let index = tableView.indexPathForSelectedRow{
                    let diningHall = index.section == 0 ? diningData.diningHalls[index.row] : diningData.retailDining[index.row]
                    if let diningURL = diningHall.url {
                        webVC.diningURL = diningURL
                        webVC.title = diningHall.name
                    }
                }
            }
        }
    }
    
}
