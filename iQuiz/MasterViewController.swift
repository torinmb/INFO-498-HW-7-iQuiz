//
//  MasterViewController.swift
//  iQuiz
//
//  Created by blankens on 10/29/15.
//  Copyright © 2015 Adobe. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController{

    var detailViewController: DetailViewController? = nil
    var objects = [("Mathmatics", "Study party?"), ("Marvel Super Heroes", "shrooms & costumes"), ("Science", "Space and stuff")]


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        let settings = UIBarButtonItem(image: UIImage(named: "Settings"), style: .Plain, target: self, action: "selectedSettings:")
        self.navigationItem.rightBarButtonItem = settings
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func selectedSettings(sender: AnyObject) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object.0
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell?
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier) as UITableViewCell
        }
        let object = objects[indexPath.row]
        cell!.textLabel!.text = object.0
        cell!.detailTextLabel!.text = object.1
        return cell!

        
    }


}

