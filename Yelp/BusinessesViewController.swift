//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var businesses: [Business]!
    var filteredBusinesses: [Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initiate the tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        // Dynamic Height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        // Initiate the SearchBar
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self

        // Get the data from the network
        loadDataFromNetwork()
        
        // A bit of formatting
        self.navigationController!.navigationBar.tintColor = UIColor.blackColor()
    }

    override func viewWillAppear(animated: Bool) {
        // Remove any selected styles from cells
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredBusinesses != nil {
            return filteredBusinesses!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
        cell.business = filteredBusinesses[indexPath.row]
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadDataFromNetwork() {
        // Default search
        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredBusinesses = businesses
            self.tableView.reloadData()
        
            for business in businesses {
                //print(business.name!)
                //print(business.address!)
            }
        })
        
        // Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredBusinesses = businesses
            self.tableView.reloadData()
        
            for business in businesses {
                //print(business.name!)
                //print(business.address!)
            }
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // If the searchBar text field is empty, set the filtered businesses to the full businesses list
        if searchText.isEmpty {
            filteredBusinesses = businesses
        }
            // Otherwise, filter through the full businesses list based on the text in the searchBar field
        else {
            Business.searchWithTerm(searchText, completion: { (businesses: [Business]!, error: NSError!) -> Void in
                self.businesses = businesses
                self.filteredBusinesses = businesses
            })
        }
        // Reload the tableView data to show only the desired results
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Check for the correct segue
        if segue.identifier == "toInfoViewController" {
            
            // Get the selected index
            let selectedIndex = tableView.indexPathForCell(sender as! UITableViewCell)
            let business = filteredBusinesses![selectedIndex!.row]
            
            // Pass the movie info to the destination controller
            let itemToAdd = segue.destinationViewController as! BusinessesInfoViewController
            itemToAdd.business = business
        }
    }
}
