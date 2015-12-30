//
//  DonationListVC.swift
//  Donate
//
//  Created by özgür on 28.12.2015.
//  Copyright © 2015 ozgur. All rights reserved.
//

import UIKit

class DonationListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,
PayPalPaymentDelegate{

    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnectWithEnvironment(newEnvironment)
            }
        }
    }

    
    #if HAS_CARDIO
    var acceptCreditCards: Bool = true {
    didSet {
    payPalConfig.acceptCreditCards = acceptCreditCards
    }
    }
    #else
    var acceptCreditCards: Bool = false {
        didSet {
            payPalConfig.acceptCreditCards = acceptCreditCards
        }
    }
    #endif
    
    var resultText = ""
    var payPalConfig = PayPalConfiguration()
    
    var selectedList = [Charity]()
    @IBOutlet var donationListTable: UITableView!
    
    @IBOutlet var totalAmount: UILabel!
    
    //MARK:View
    override func viewDidLoad() {
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true
        self.navigationController!.view.backgroundColor = UIColor.clearColor()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
       
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        donationListTable.addBlurryBackground(view)
        donationListTable.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // Set up payPalConfig
        payPalConfig.acceptCreditCards = acceptCreditCards;
        payPalConfig.merchantName = "EveryDayHero, Inc."
        payPalConfig.merchantPrivacyPolicyURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        
        
        payPalConfig.payPalShippingAddressOption = .PayPal;
        
        print("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnectWithEnvironment(environment)
    }
    
    func dismissKeyboard() {
       
        view.endEditing(true)
    }
    
    // MARK: Payment
    @IBAction func donateActionClick(sender: AnyObject) {
     
        // Remove our last completed payment, just for demo purposes.
            resultText = ""

      var total:Double = 0.0
        for a in  0...selectedList.count-1
        {
     
            let index = NSIndexPath(forRow: a, inSection: 0)
            
            let cell = donationListTable.cellForRowAtIndexPath(index)
            
            
          for view in (cell?.contentView.subviews)!
          {
            if view.isKindOfClass(UITextField)
            {
                let textfield = view as! UITextField
                if let value = Double(textfield.text!)
                {
                    total += value
                }
                
            }
            }
        }
        
     
        let item1 = PayPalItem(name: "EveryDayHero Donation",
            withQuantity: 1,
            withPrice: NSDecimalNumber(string: String(format:"%f", total)),
            withCurrency: "USD", withSku: "GM-0037")

        
        let items = [item1]
        let subtotal = PayPalItem.totalPriceForItems(items)
        

        let payment = PayPalPayment(amount: subtotal, currencyCode: "USD", shortDescription: "EveryDayHero Donation", intent: .Sale)
        
        payment.items = items
        //payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            presentViewController(paymentViewController, animated: true, completion: nil)
        }
        else {
            print("Payment not processalbe: \(payment)")
        }
        

    }
    // PayPalPaymentDelegate
    
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController!) {
        print("PayPal Payment Cancelled")
        resultText = ""
       
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController!, didCompletePayment completedPayment: PayPalPayment!) {
        print("PayPal Payment Success !")
        paymentViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
           
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            
            self.resultText = completedPayment!.description
          
        })
    }

    
    //MARK: TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:DonationListCell = tableView.dequeueReusableCellWithIdentifier("donationListCell") as! DonationListCell
        
        let charity:Charity = selectedList[indexPath.row]
        
        cell.charityName.text = charity.name
        cell.tag = indexPath.row
        
        return cell
    }
}
