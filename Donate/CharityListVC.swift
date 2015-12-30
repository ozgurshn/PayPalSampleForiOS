//
//  ViewController.swift
//  Donate
//
//  Created by özgür on 23.12.2015.
//  Copyright © 2015 ozgur. All rights reserved.
//

import UIKit


class CharityListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var charityList = [Charity]()
    var selectedElements = [NSIndexPath]()
    var imageCache = [String:UIImage]()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        configureTableView()
        
        listCharities { (array, error) -> Void in

            self.charityList = Charity.charityWithJSON(array)
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        }
    }
    
    
    // MARK: TableView
    func configureTableView() {
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 190.0
        tableView.rowHeight = UITableViewAutomaticDimension;
        
        tableView.addBlurryBackground(view)
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(indexPath.row)
        let cell:CharityListCell = self.tableView.dequeueReusableCellWithIdentifier("charityCell") as! CharityListCell
        

        if selectedElements.contains(indexPath)
        {
            cell.checkMarkImage.hidden = false
            return cell
        }
        else
        {
            cell.checkMarkImage.hidden = true
            
        }
        
        
        let charity = charityList[indexPath.row]
        
        cell.nameLabel.text = charity.name
        cell.charityDescription.text = charity.description
        
        //IamgeCache handle
        if let img = imageCache[charity.logo_url] {
            cell.charityImage?.image = img
        }
        else {
            let imgURL = NSURL(string: charity.logo_url)
            let request: NSURLRequest = NSURLRequest(URL: imgURL!)
            
            
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            
            
            let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
                
                if error == nil {
                    if let image = UIImage(data: data!)
                    {
                        self.imageCache[charity.logo_url] = image
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            if let cellToUpdate:CharityListCell = tableView.cellForRowAtIndexPath(indexPath) as? CharityListCell {
                                cellToUpdate.charityImage?.image = image
                                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
                            }
                        })
                    }
                    
                }
                else {
                    print("Error: \(error!.localizedDescription)")
                }
                
                
            });
            
            task.resume()
            
            
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charityList.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        let cell:CharityListCell  = tableView.cellForRowAtIndexPath(indexPath) as! CharityListCell
             cell.checkMarkImage.hidden = false
            selectedElements.append(indexPath)
         cell.contentView.alpha = 1.0

    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:CharityListCell  = tableView.cellForRowAtIndexPath(indexPath) as! CharityListCell
         cell.checkMarkImage.hidden = true
        selectedElements.removeAtIndex(selectedElements.indexOf(indexPath)!)
       cell.contentView.alpha = 0.9
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        

        var selectedList = [Charity]()
        for indexPath in selectedElements
        {
            selectedList.append(charityList[indexPath.row])
        }
        
        let nextVC:DonationListVC = segue.destinationViewController as! DonationListVC
        nextVC.selectedList = selectedList
    }
   
    
}
