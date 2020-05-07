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

class NoticeViewModel: ObservableObject {
    @Published var events: [Event] = []
    
    func getSchedule() {}
}

final class NetworkNoticeViewModel: NoticeViewModel {
    var cancellable: Cancellable?
    
    override func getSchedule() {
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
            "psize": "100"
        ]
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        let url = urlComponents.url!
        
        cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ScheduleWrapper.self, decoder: JSONDecoder())
            .map { $0.schedule.events }
            .retry(1)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.events, on: self)
    }
}

final class StubNoticeViewModel: NoticeViewModel {
    override init() {
        super.init()
        
        guard
            let url = Bundle.main.url(
                forResource: "sampleSchedule",
                withExtension: "json"
            ),
            let data = try? Data(contentsOf: url),
            let wrapper = try? JSONDecoder()
                .decode(ScheduleWrapper.self, from: data)
        else { return }
        events = wrapper.schedule.events
    }
}
