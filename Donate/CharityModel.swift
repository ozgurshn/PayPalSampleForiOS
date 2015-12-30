//
//  CharityModel.swift
//  Donate
//
//  Created by özgür on 23.12.2015.
//  Copyright © 2015 ozgur. All rights reserved.
//

import Foundation

struct Charity {
    let name: String
    let id: String
    let slug: String
    let country_code: String
    let description: String
    let gift_aid: String
    let logo_url: String
    let url: String
    let amount: Float
    
    
    init(name: String, id: String, slug: String, country_code: String, description: String, gift_aid: String
        , logo_url: String, url: String ) {
        self.name = name
        self.id = id
        self.slug = slug
        self.country_code = country_code
        self.description = description
        self.gift_aid = gift_aid
            self.logo_url = logo_url
            self.url = url
          self.amount = 0
    }
    

    static func charityWithJSON(results: NSArray) -> [Charity] {

        var charityList = [Charity]()

        if results.count>0 {
            
            for result in results {

                let name = result["name"] as? String ?? ""
                let id = result["id"] as? String ?? ""
                let slug = result["slug"] as? String ?? ""
                
                let country_code = result["country_code"] as? String ?? ""
                let description = result["description"] as? String ?? ""
                let gift_aid = result["gift_aid"] as? String ?? ""
                let logo_url = result["logo_url"] as? String ?? ""
                let url = result["url"] as? String ?? ""
                

                let newCharity = Charity(name: name, id: id, slug: slug, country_code: country_code, description: description, gift_aid: gift_aid, logo_url: logo_url, url: url)
                charityList.append(newCharity)
            }
        }
        return charityList
    }
}