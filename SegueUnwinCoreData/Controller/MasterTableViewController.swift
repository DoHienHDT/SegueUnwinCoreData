//
//  MasterTableViewController.swift
//  SegueUnwinCoreData
//
//  Created by dohien on 7/16/18.
//  Copyright © 2018 hiền hihi. All rights reserved.
//

import UIKit
class MasterTableViewController: UITableViewController , UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        search = DataSerVice.shared.arrays.filter({(searchData : Entity) -> Bool in
            return (searchData.name?.lowercased().contains(searchController.searchBar.text!.lowercased()))!
        })
        tableView.reloadData()
    }
    var search : [Entity] = []
    let controller = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.searchResultsUpdater = self
        controller.dimsBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        self.tableView.tableHeaderView = controller.searchBar
        controller.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        self.tableView.reloadData()
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
        if controller.isActive {
            return search.count
        }else {
            return DataSerVice.shared.arrays.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell
        
        var listEntity : [Entity] = []
        if controller.isActive {
            listEntity = search
        }else {
            listEntity = DataSerVice.shared.arrays
        }
        cell.nameLabel.text = (String(DataSerVice.shared.arrays[indexPath.row].age))
        cell.nameTextField.text = DataSerVice.shared.arrays[indexPath.row].name
        cell.photoImage.image = DataSerVice.shared.arrays[indexPath.row].image as? UIImage
        return cell
    }
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
