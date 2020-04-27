//
//  ScheduleWrapper.swift
//  SchoolNewsLetter
//
//  Created by Jay Lee on 2020/04/23.
//  Copyright © 2020 Jay Lee. All rights reserved.
//

import Foundation

struct ScheduleWrapper: Decodable {
    var schedule: Schedule

    enum CodingKeys: String, CodingKey {
        case schedule = "SchoolSchedule"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        var container = try values.nestedUnkeyedContainer(forKey: .schedule)
        _ = try container.decode(DummyDecodable.self)
        self.schedule = try container.decode(Schedule.self)
    }
}
