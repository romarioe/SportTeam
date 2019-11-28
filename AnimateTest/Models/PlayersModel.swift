//
//  PlayersModel.swift
//  AnimateTest
//
//  Created by Roman Efimov on 22/10/2019.
//  Copyright © 2019 Roman Efimov. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    var players: [Player]
}

struct Player: Decodable{
    let number: String
    let name: String
    let lastname: String
    let amplua: String
    let status: String
    //let dayofbirth: String
    let photo: String
    let osnovnoi: String
}
