//
//  WeatherTableViewController.swift
//  Capstone
//
//  Created by Danielle Alloy on 5/10/19.
//  Copyright © 2019 Danielle Alloy. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    var myWeather = WeatherModelCollection()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        myWeather.getWeather() {
            print("I'm in the completion handler. Have \(self.myWeather.getForcastCount()) forcasts")
            self.tableView.reloadData()
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
        print("In \(#function) returning \(myWeather.getForcastCount())")
        return myWeather.getForcastCount()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherReuse", for: indexPath)

        // Configure the cell...
        let row = indexPath.row
        if let actualCell = cell as? WeatherTableViewCell,
            let theForcast = myWeather.thisWeekWeather?[row] {
            
            actualCell.dayofWeekLabel.text = theForcast.weekday
            //let theStringLowTemp = String(format:"%f", theForcast.lowTemperature)
            actualCell.lowTempLabel.text = theForcast.covertToFahrenheit(temperature: theForcast.lowTemperature)
            //let theStringHighTemp = String(format:"%f", theForcast.highTemperature)
            actualCell.highTempLabel.text = theForcast.covertToFahrenheit(temperature: theForcast.highTemperature)
            actualCell.percipChanceLabel.text = theForcast.percipChance
            actualCell.descriptionLabel.text = theForcast.description
            actualCell.windSpeedLabel.text = theForcast.covertToMPH(speed: theForcast.windSpeed) 
            actualCell.windDescription.text = theForcast.windDesc
           actualCell.weatherIcon.image = theForcast.getThumbnail()
                {
                // reload
                self.tableView.reloadRows(
                    at: [indexPath],
                    with: .automatic)
            }
        }
        

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