# PayPalSampleForiOS

Simple PayPal implementation using Swift.


*  Self-sizing table view cell
*  Custom selection style and multi selection
*  Async image loading and image caching
*  Auto layout
*  Blurry background
*  Custom button ([SimpleButton](https://github.com/aloco/SimpleButton))


![alt tag](https://raw.githubusercontent.com/ozgurshn/PayPalSampleForiOS/master/Donate/donate.gif)

Simple network request using completion handler.

```Swift
listCharities { (array, error) -> Void in

            self.charityList = Charity.charityWithJSON(array)
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        }
```