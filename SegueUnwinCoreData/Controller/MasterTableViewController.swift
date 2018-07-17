//
//  MasterTableViewController.swift
//  SegueUnwinCoreData
//
//  Created by dohien on 7/16/18.
//  Copyright © 2018 hiền hihi. All rights reserved.
//

import UIKit
import CoreData
class MasterTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataSerVice.shared.arrays.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell
        cell.nameLabel.text = String(DataSerVice.shared.arrays[indexPath.row].age)
        cell.nameTextField.text = DataSerVice.shared.arrays[indexPath.row].name
        cell.photoImage.image = DataSerVice.shared.arrays[indexPath.row].image as? UIImage
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataSerVice.shared.remove(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let detailViewController = segue.destination as? DetailViewController {
            if let index = tableView.indexPathForSelectedRow {
                detailViewController.object = DataSerVice.shared.arrays[index.row]
            }
        }
    }
    
    
}
