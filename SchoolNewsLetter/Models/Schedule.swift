//
//  Schedule.swift
//  SchoolNewsLetter
//
//  Created by Jay Lee on 2020/04/23.
//  Copyright © 2020 Jay Lee. All rights reserved.
//

import Foundation

struct Schedule: Decodable {
    var events: [Event]

    enum CodingKeys: String, CodingKey {
        case events = "row"
    }
}
