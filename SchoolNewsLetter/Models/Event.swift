//
//  Event.swift
//  SchoolNewsLetter
//
//  Created by Jay Lee on 2020/04/23.
//  Copyright © 2020 Jay Lee. All rights reserved.
//

import Foundation

struct Event: Decodable, Hashable {
    var rawDate: String
    var title: String
    var firstGrade: Bool
    var secondGrade: Bool
    var thirdGrade: Bool
    
    var dateRepresentation: String? {
        guard let date = Calendar.current.date(from: rawDate) else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = .current
        
        return dateFormatter.string(from: date)
        
    }

    enum CodingKeys: String, CodingKey {
        case rawDate = "AA_YMD"
        case title = "EVENT_NM"
        case firstGrade = "ONE_GRADE_EVENT_YN"
        case secondGrade = "TW_GRADE_EVENT_YN"
        case thirdGrade = "THREE_GRADE_EVENT_YN"
    }

    private static func decodeBool<Container: KeyedDecodingContainerProtocol> (
        _ values: Container,
        forKey key: Container.Key
    ) throws -> Bool {
        let rawValue = try values.decode(String.self, forKey: key)

        switch rawValue {
        case "Y": return true
        case "N": return false
        default:
            throw DecodingError.dataCorruptedError(
                forKey: key,
                in: values,
                debugDescription: "\(rawValue) is not convertible to Bool"
            )
        }
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rawDate = try values.decode(String.self, forKey: .rawDate)
        title = try values.decode(String.self, forKey: .title)
        firstGrade = try Event.decodeBool(values, forKey: .firstGrade)
        secondGrade = try Event.decodeBool(values, forKey: .secondGrade)
        thirdGrade = try Event.decodeBool(values, forKey: .thirdGrade)
    }
}
