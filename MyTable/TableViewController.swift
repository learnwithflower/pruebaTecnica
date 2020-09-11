//
//  TableViewController.swift
//  MyTable
//
//  Created by Flor Valero on 08/09/2020.
//  Copyright © 2020 Flor Valero. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var show: [AnyObject] = []
    var descriptionArray: [AnyObject] = []
    var dateArray: [AnyObject] = []
    var idArray: [AnyObject] = []
    var amountArray: [AnyObject] = []
    var feeArray: [AnyObject] = []
    var totalArray: [AnyObject] = []
    var hourArray: [AnyObject] = []
    var colourArray: [AnyObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://code-challenge-e9f47.web.app/transactions.json"
        let url = URL(string: urlString)!
        let data = try! Data(contentsOf: url)
        let JSON = try! JSONSerialization.jsonObject(with: data, options: [])
        if let jsonArray = JSON as? [[String: Any]] {
                    for item in jsonArray {
                        let date = item["date"] as? String ?? "" //A default value
                        let description = item["description"] as? String
                        let id = item["id"] as? Double
                        let amount = item["amount"] as? Double
                        let fee = (item["fee"] ?? 0.0) as? Double
                        let total = (amount ?? 0.0) - (fee ?? 0.0)
                         
                        let formatter = Foundation.DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ" //2017-04-01T18:05:00.000
                        let date1  = formatter.date(from: date)
                        
                        if date1 != nil {
                            formatter.dateStyle = .short
                            let date2 = formatter.string(from: date1!)
                            print("Día:\(String(describing: date2))")
                            formatter.timeZone = TimeZone(abbreviation: "UTC")
                            formatter.dateFormat = "HH:mm"
                            let resultTime = formatter.string(from: date1!)
                            print("Hora:\(String(describing: resultTime))")
                            
                            self.show.append(date1 as AnyObject)
                            self.descriptionArray.append(description as AnyObject)
                            self.amountArray.append(amount as AnyObject)
                            self.idArray.append(id as AnyObject)
                            self.feeArray.append(fee as AnyObject)
                            self.dateArray.append(date2 as AnyObject)
                            self.hourArray.append(resultTime as AnyObject)
                            self.totalArray.append(total as AnyObject)
    
                            print(show.count)
                            print(descriptionArray.count)
                            print(feeArray)
                            print(totalArray)
                            
                            if (total >= 0.0) {
                                self.colourArray.append(UIColor.green as AnyObject)
                            } else {
                                self.colourArray.append(UIColor.red as AnyObject)
                            }
                            
                            print(colourArray)
                            
                            
                        }
                        
                    }
                }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.show.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TransactionTableViewCell

        // Configure the cell...
        //cell.textLabel?.text = descriptionArray[indexPath.row] as? String
        // Para la label descripción
        cell.descriptionLabel.text = descriptionArray[indexPath.row] as? String
//        if cell.descriptionLabel.text == "" {
//            cell.descriptionLabel.text = ""
//        }
        // Para id
        cell.idLabel.text = "ID: \(idArray[indexPath.row])"
        // Para amount
        cell.amountLabel.text = "Amount: \(amountArray[indexPath.row]) €"
        // Para fee
        cell.feeLabel.text = "Fee: \(feeArray[indexPath.row]) €"
        // Para day
        cell.dateLabel.text = dateArray[indexPath.row] as? String
        // Para hour
        cell.hourLabel.text = hourArray[indexPath.row] as? String
        // Para total
        cell.totalLabel.text = "Total: \(totalArray[indexPath.row]) €"
        // Para el color
        cell.colorView.backgroundColor = colourArray[indexPath.row] as? UIColor
        
        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
