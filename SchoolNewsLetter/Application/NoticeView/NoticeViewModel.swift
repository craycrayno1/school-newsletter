//
//  NoticeViewModel.swift
//  SchoolNewsLetter
//
//  Created by Jay Lee on 2020/04/23.
//  Copyright © 2020 Jay Lee. All rights reserved.
//

import Combine
import Foundation

// C: malloc / free
// C++: new / delete OR RAII
// Garbage Collection : GC
// Automatic Reference Counting : ARC

class NoticeViewModel {
    var cancellable: Cancellable?
    
    func getSchedule() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "open.neis.go.kr"
        urlComponents.path = "/hub/SchoolSchedule"
        
        let parameters = [
            "key": "d47ea07feb304beb9622c7dc63321404",
            "type": "json",
            "sd_schul_code": "7091444",
            "atpt_ofcdc_sc_code": "B10",
            "aa_from_ymd": "20200415",
            "psize": "3"
        ]
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        cancellable = URLSession.shared
            .dataTaskPublisher(for: urlComponents.url!)
            .map { $0.data }
            .decode(type: ScheduleWrapper.self, decoder: JSONDecoder())
            .map { $0.schedule.events }
            .retry(1)

            .replaceError(with: [])
            .sink { print($0) }
        
    }
}
